// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "LandingScreen",
    platforms: [
        .iOS(.v14)
    ],
    products: [
        .library(name: "LandingScreen", targets: ["LandingScreen"]),
    ],
    dependencies: [
        .package(path: "../Shared/Extensions"),
        .package(path: "../Shared/Location"),
        .package(path: "../Shared/Components"),
        .package(path: "../Features/TabBar"),
        .package(name: "shared", path: "../../../../shared/swiftpackage")
    ],
    targets: [
        .target(name: "LandingScreen", dependencies: ["shared", "Extensions", "Location", "Components", "TabBar"]),
        .testTarget(name: "LandingScreenTests", dependencies: ["LandingScreen"]),
    ]
)
