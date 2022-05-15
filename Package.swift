// swift-tools-version: 5.5
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "CleanNetwork",
    platforms: [
        .iOS(.v13),
        .macOS(.v10_15),
        .tvOS(.v13),
        .watchOS(.v6)
    ],
    products: [
        .library(
            name: "CleanNetwork",
            targets: ["CleanNetwork"]),
    ],
    targets: [
        .target(
            name: "CleanNetwork",
            dependencies: []),
        .testTarget(
            name: "CleanNetworkTests",
            dependencies: ["CleanNetwork"]),
    ]
)
