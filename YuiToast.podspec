#
#  Be sure to run `pod spec lint YuiToast.podspec' to ensure this is a
#  valid spec and to remove all comments including this before submitting the spec.
#
#  To learn more about Podspec attributes see https://guides.cocoapods.org/syntax/podspec.html
#  To see working Podspecs in the CocoaPods repo see https://github.com/CocoaPods/Specs/
#

Pod::Spec.new do |spec|
  spec.name         = "YuiToast"
  spec.version      = "0.1.1"
  spec.summary      = "A lightweight toast library for iOS."
  spec.platform     = :ios
  spec.ios.deployment_target = '11.0'
  spec.swift_version = '5.0'
  spec.description  = <<-DESC
YuiToast is a lightweight toast display library for iOS. It can be display toast and modify the toast appeared on the screen easily in your iOS apps.
DESC
  spec.homepage     = "https://github.com/jctaoo/YuiToast"
  spec.license      = "MIT"
  spec.author             = { "jctaoo" => "jctaoo@outlook.com" }
  spec.source       = { :git => "https://github.com/jctaoo/YuiToast.git", :tag => spec.version }
  spec.source_files  = "Sources/**/*"
  spec.frameworks = 'UIKit'
  spec.dependency 'SnapKit', '5.0.0'
end
