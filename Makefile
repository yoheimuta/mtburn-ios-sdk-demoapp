MTB_PROJECT=DemoApp.xcodeproj

MTB_TEST_TARGET=UnitTests
MTB_SCHEME=DemoApp
MTB_PROFILE=iOS_Team_Provisioning_Profile_.mobileprovision
MTB_CERTIFICATE=ios_distribution.cer

SECURITY_PASSWORD=travis
SECURITY_KEYCHAIN=ios-build.keychain
SECURITY_KEYCHAIN_PATH=~/Library/Keychains/ios-build.keychain
SECURITY_APP_PATH=/usr/bin/codesign

release:
	if [ -z "$(CURRENT_VERSION)" ] ; then exit 1; fi
	if [ -z "$(NEXT_VERSION)" ] ; then exit 1; fi
	git checkout master
	sed -i '' -e"s/$(CURRENT_VERSION)/$(NEXT_VERSION)/g" \
		DemoApp/DemoApp-Info.plist
	git add .
	git commit -m"Updated version to v$(NEXT_VERSION)"
	git tag -a v$(NEXT_VERSION) -m"Updated version to v$(NEXT_VERSION)"
	git push --tags origin master

test:
	xcodebuild clean test \
		-sdk iphonesimulator \
		-project $(MTB_PROJECT) \
		-scheme $(MTB_SCHEME) \
		-configuration Debug \
		OBJROOT=build \
		GCC_INSTRUMENT_PROGRAM_FLOW_ARCS=YES \
		GCC_GENERATE_TEST_COVERAGE_FILES=YES

certificates-download:
	@bundle exec ios certificates:download "yoshimuta yohei" \
		--type distribution \
		-u yoheimuta \
		-p $(IOS_PASSWORD)

profiles-download:
	@bundle exec ios profiles:download \
		-u yoheimuta \
		-p $(IOS_PASSWORD) \
		"iOS Team Provisioning Profile: *"

decrypt-p12:
	@openssl aes-256-cbc \
		-k $(DECORD_CERTS) \
		-in ./.travis/dist.p12.enc -d -a -out ./.travis/dist.p12

create-keychain:
	security create-keychain -p $(SECURITY_PASSWORD) $(SECURITY_KEYCHAIN)
	security default-keychain -s $(SECURITY_KEYCHAIN)
	security unlock-keychain -p $(SECURITY_PASSWORD) $(SECURITY_KEYCHAIN)
	security set-keychain-settings -t 3600 -u $(SECURITY_KEYCHAIN)

add-certificates: certificates-download profiles-download decrypt-p12 create-keychain
	security import ./.travis/AppleWWDRCA.cer -k $(SECURITY_KEYCHAIN_PATH) -T $(SECURITY_APP_PATH)
	@security import ./.travis/dist.p12 -k $(SECURITY_KEYCHAIN_PATH) -P $(DECORD_CERTS) -T $(SECURITY_APP_PATH)
	security import ./$(MTB_CERTIFICATE) -k $(SECURITY_KEYCHAIN_PATH) -T $(SECURITY_APP_PATH)
	mkdir -p ~/Library/MobileDevice/Provisioning\ Profiles
	cp $(MTB_PROFILE) ~/Library/MobileDevice/Provisioning\ Profiles/

remove-certificates:
	security delete-keychain $(SECURITY_KEYCHAIN)
	rm -f "~/Library/MobileDevice/Provisioning Profiles/$(MTB_PROFILE)"

ipa: add-certificates
	bundle exec ipa build \
		--embed $(MTB_PROFILE) \
		--configuration Release \
		--sdk iphoneos \
		--project $(MTB_PROJECT) \
		--scheme $(MTB_SCHEME)

append-pr-to-bundleid:
	sed -i '' -e"s/rfc1034identifier)2/rfc1034identifier)2-pr/g" \
		DemoApp/DemoApp-Info.plist

append-master-to-bundleid:
	sed -i '' -e"s/rfc1034identifier)2/rfc1034identifier)2-master/g" \
		DemoApp/DemoApp-Info.plist

deploygate:
	@bundle exec ipa distribute:deploygate \
		-a $(DEPLOYGATE_API_KEY) \
		-u yoheimuta \
		-f DemoApp.ipa \
		-m $(DEPLOYGATE_MESSAGE)

send-coverage:
	coveralls \
		-r ./ -E ".*/UnitTests/.*"
