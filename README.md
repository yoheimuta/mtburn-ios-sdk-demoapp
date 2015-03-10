# mtburn-ios-sdk-demoapp

[![Build Status](https://travis-ci.org/yoheimuta/mtburn-ios-sdk-demoapp.svg?branch=master)](https://travis-ci.org/yoheimuta/mtburn-ios-sdk-demoapp)
[![Coverage Status](https://coveralls.io/repos/yoheimuta/mtburn-ios-sdk-demoapp/badge.svg)](https://coveralls.io/r/yoheimuta/mtburn-ios-sdk-demoapp)

- [MTBurn-iOS-SDK-Install-Guide](https://github.com/mtburn/MTBurn-iOS-SDK-Install-Guide) describes how to use mtburn-ios-sdk.
- below describes ios-automated-release-flow using `travis-ci`.

### Pull Requests

Click a creation of p-r button on the top page of github.

Then, CI starts to automate 3 steps below with CI.

1. test
2. build ipa
3. deploy to deploygate of [DemoApp-pr](https://deploygate.com/users/yoheimuta/platforms/ios/apps/com.ADVSurn.DemoApp2-pr)

Allow non-engineers to review developing app on each device before merge.

- Identify the specific app on deploygate using release notes of `39c97f9#7`(git-commit-hash#PR-number) .

### Merge Master

Click a merge button on the page of github pull request.

Then, CI starts to automate 3 steps below with CI.

1. test
2. build ipa
3. deploy to deploygate of [DemoApp-master](https://deploygate.com/users/yoheimuta/platforms/ios/apps/com.ADVSurn.DemoApp2-master)

Allow non-engineers to install master(but not released yet) app on each device at any time.

- Identify the specific app on deploygate using release notes of `5a39f0e`(git-commit-hash) .

### Tag Commit

Run a release command at the repository.

```sh
# ex. version up to 1.0.0
$ cd ./mtburn-ios-sdk-demoapp
$ make release NEXT_VERSION=1.0.0
```

Then, CI starts to automate 7 steps below with CI.

1. test
2. build ipa
3. deploy to deploygate of [DemoApp](https://deploygate.com/users/yoheimuta/platforms/ios/apps/com.ADVSurn.DemoApp2)
4. deploy to [github releases](https://github.com/yoheimuta/mtburn-ios-sdk-demoapp/releases)
5. clone, update files(framework/demo project/podspec/appledoc), commit, tag and push the [dependent repository](https://github.com/yoheimuta/mtburn-ios-sdk-demoapp-public) on this repository content to upstream.
6. update gh-pages of the [dependent repository](https://github.com/yoheimuta/mtburn-ios-sdk-demoapp-public). see the [generated document](http://yoheimuta.github.io/mtburn-ios-sdk-demoapp-public/appledoc/latest/index.html).
7. deploy to [github releases](https://github.com/yoheimuta/mtburn-ios-sdk-demoapp-public/releases) of the [dependent repository](https://github.com/yoheimuta/mtburn-ios-sdk-demoapp-public).

Allow non-engineers to install released app on device at any time.

- Identify the specific app on deploygate using release notes of `5a39f0e`(git-commit-hash) .

Allow to release other dependent repository without any troublesome manual operations.

### Only Manual Operation to Be Required

[Updated] `pod trunk` enabled to use `COCOAPODS_TRUNK_TOKEN`, see [Question to be possible to automate `pod trunk push` with CI service like travisCI](https://github.com/CocoaPods/CocoaPods/issues/3224).

The only last operation to be left is `pod trunk push` of the dependent repository.
Because the command of `pod trunk register` try to authenticate per machine, not per user. And the method of authentication is confirmation of email.

If your CI service is not-self-hosted like travis-ci, it's difficult to automate `pod trunk register` and `pod trunk push` on a new machine each time of building.
