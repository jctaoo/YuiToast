// swift-tools-version:5.2
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "YuiToast",
    platforms: [
      .iOS(.v11)
    ],
    products: [
        .library(
            name: "YuiToast",
            targets: ["YuiToast"]),
    ],
    dependencies: [
      
    ],
    targets: [
        .target(
            name: "YuiToast",
            dependencies: [],
            path: "Sources")
    ],
    swiftLanguageVersions: [
      .v5
    ]
)
