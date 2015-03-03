MTB_PROJECT=DemoApp.xcodeproj

MTB_TEST_TARGET=UnitTests
MTB_SCHEME=DemoApp
MTB_PROFILE=iOS_Team_Provisioning_Profile_.mobileprovision
MTB_CERTIFICATE=ios_distribution.cer

SECURITY_PASSWORD=travis
SECURITY_KEYCHAIN=ios-build.keychain
SECURITY_KEYCHAIN_PATH=~/Library/Keychains/ios-build.keychain
SECURITY_APP_PATH=/usr/bin/codesign

PUBLIC_REPO_PATH=/tmp/mtburn-ios-sdk-demoapp-public
PUBLIC_REPO_COPY_PATH=/tmp/mtburn-ios-sdk-demoapp-public_copy

release:
	if [ -z "$(NEXT_VERSION)" ] ; then exit 1; fi
	$(eval CURRENT_VERSION := $(shell echo $$(git for-each-ref --sort=-taggerdate --format="%(tag)" refs/tags | head -n 1 | sed -e "s/v//")))
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
		-p $(IOS_PASSWORD) \
		--team MZK3N6HW3B

profiles-download:
	@bundle exec ios profiles:download \
		-u yoheimuta \
		-p $(IOS_PASSWORD) \
		--team MZK3N6HW3B \
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

archive:
	xcodebuild archive \
		-sdk iphoneos \
		-project $(MTB_PROJECT) \
		-scheme $(MTB_SCHEME) \
		-configuration Release \

clone-public-repo:
	@git clone https://$(GH_TOKEN)@github.com/yoheimuta/mtburn-ios-sdk-demoapp-public $(PUBLIC_REPO_PATH) >& /dev/null
	cp -r ./DemoApp $(PUBLIC_REPO_PATH)/demo/
	cp -r ./DemoApp.xcodeproj $(PUBLIC_REPO_PATH)/demo/
	cp -r ./AppDavis.framework $(PUBLIC_REPO_PATH)/

update-public-repo: clone-public-repo
	$(eval CURRENT_VERSION := $(shell cd $(PUBLIC_REPO_PATH); echo $$(git for-each-ref --sort=-taggerdate --format="%(tag)" refs/tags | head -n 1 | sed -e "s/v//")))
	if [ -z "$(CURRENT_VERSION)" ] ; then exit 1; fi
	if [ -z "$(NEXT_VERSION)" ] ; then exit 1; fi
	@cd $(PUBLIC_REPO_PATH); \
		appledoc --project-name AppDavis.framework --project-company TEMP --create-html --no-create-docset --output ./docs ./AppDavis.framework/Headers/; \
		sed -i '' -e"s/$(CURRENT_VERSION)/$(NEXT_VERSION)/g" Dummy.podspec; \
		git add .; \
		git commit -m"Updated version to v$(NEXT_VERSION)"; \
		git tag -a v$(NEXT_VERSION) -m"Updated version to v$(NEXT_VERSION)"; \
		git push --tags https://$(GH_TOKEN)@github.com/yoheimuta/mtburn-ios-sdk-demoapp-public master >& /dev/null;

release-public-repo: update-public-repo
	cp -r $(PUBLIC_REPO_PATH) $(PUBLIC_REPO_COPY_PATH)
	@cd $(PUBLIC_REPO_PATH); \
		git checkout gh-pages; \
		mv $(PUBLIC_REPO_COPY_PATH)/docs appledoc/$(NEXT_VERSION); \
		rm -r appledoc/latest; \
		(cd appledoc && ln -s $(NEXT_VERSION)/html latest); \
		git add appledoc/; \
		git clean -fdx; \
		git commit -m"Added appledoc that corresponded to SDK version $(NEXT_VERSION)"; \
		git push https://$(GH_TOKEN)@github.com/yoheimuta/mtburn-ios-sdk-demoapp-public gh-pages >& /dev/null;

deploy-public-repo:
	@cd $(PUBLIC_REPO_PATH); \
		dpl --provider=releases --api-key=$(GH_TOKEN) --repo=yoheimuta/mtburn-ios-sdk-demoapp-public --skip_cleanup
