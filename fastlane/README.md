fastlane documentation
================
# Installation

Make sure you have the latest version of the Xcode command line tools installed:

```
xcode-select --install
```

Install _fastlane_ using
```
[sudo] gem install fastlane -NV
```
or alternatively using `brew cask install fastlane`

# Available Actions
## iOS
### ios test
```
fastlane ios test
```
Test multi target project
### ios new_build
```
fastlane ios new_build
```
Generates new build
### ios new_testflight
```
fastlane ios new_testflight
```
Generates new build and submit to testflight
### ios new_fabric
```
fastlane ios new_fabric
```
Generates new build and submit to Fabric
### ios new_push_certificate
```
fastlane ios new_push_certificate
```
Generates new Push Notification certificate
### ios new_screenshots
```
fastlane ios new_screenshots
```
Generates App Screenshots

----

This README.md is auto-generated and will be re-generated every time [fastlane](https://fastlane.tools) is run.
More information about fastlane can be found on [fastlane.tools](https://fastlane.tools).
The documentation of fastlane can be found on [docs.fastlane.tools](https://docs.fastlane.tools).
