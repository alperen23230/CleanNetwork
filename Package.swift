// swift-tools-version: 5.10
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "CleanNetwork",
    platforms: [
        .iOS(.v15),
        .macOS(.v12),
        .tvOS(.v15),
        .watchOS(.v8)
    ],
    products: [
        .library(
            name: "CleanNetwork",
            targets: ["CleanNetwork"]),
    ],
    targets: [
        .target(
            name: "CleanNetwork",
            dependencies: [],
            path: "Sources"
        ),
        .testTarget(
            name: "CleanNetworkTests",
            dependencies: ["CleanNetwork"],
            resources: [
                .process("Supporting Files")
            ]
        )
    ]
)
