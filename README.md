# YuiToast

A lightweight toast library for iOS.

## Requirements
- iOS 11 or any higher version.
- Preferably Swift 5.0 or any higher version.
- The library has not been tested with Swift 4.x or any lower version.

## Features:
- Display toast (Can contain small pictures) in one line code.
- Modify the toast content appeared on the screen easily. 

## Example Project

The example project contains some usages of YuiToast. You can use and modify as your like.

### Example Project Installation
Clone or download YuiToast first and run the following command:
```shell
cd YuiToast/Example
pod install
```
Then, open Example.xcworkspace.

## Installation

### CocoaPods
[CocoaPods](https://cocoapods.org/) is a dependency manager for Cocoa projects. You can install it with the following command:
```shell
gem install cocoapods
```
To integrate YuiToast into your Xcode project using CocoaPods, specify it in your Podfile:
```Ruby
platform :ios, '11.0'

target 'Your Project Name' do
  use_frameworks!
  # Pods for Your Project Name
  pod 'YuiToast', '0.1.0'
end
```
Then, run the following command:
```shell
pod install
```

## Usage

### Show text toast:
```swift
import YuiToast

Toast.default.show(message: "Hello World")
```

### Show toast with text and image:
```swift
import YuiToast

Toast.default.show(message: "Toast With Image", image: UIImage(named: "DemoImage"))
```

### Set the timing of disappearance
```swift
import YuiToast

Toast.default.show(message: "Hello World", duration: .never) // never disappear
Toast.default.show(message: "Hello World", duration: .timeInterval(duration: 3)) // disappears after 3 seconds
```

### Show any custom ToastItem
```swift
func show(_ toastItem: ToastItem)
```

### Modify appeared Toast
```swift
import YuiToast

let item = Toast.defaut.show(...)
Toast.default.update(item: item) { item in
  item.title = "updated"
}
```

## License
Copyright (c) 2020 Tao Juncheng

[LICENSE](/LICENSE) file
