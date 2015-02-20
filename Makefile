MTB_PROJECT=DemoApp.xcodeproj

MTB_TEST_TARGET=UnitTests
MTB_TEST_SCHEME=DemoApp

test:
	xcodebuild clean test \
		-sdk iphonesimulator \
		-project $(MTB_PROJECT) \
		-scheme $(MTB_TEST_SCHEME) \
		-configuration Debug \
		OBJROOT=build \
		GCC_INSTRUMENT_PROGRAM_FLOW_ARCS=YES \
		GCC_GENERATE_TEST_COVERAGE_FILES=YES

send-coverage:
	coveralls \
		-r ./ -E ".*/UnitTests/.*"
