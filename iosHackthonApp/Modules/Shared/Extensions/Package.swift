// swift-tools-version:5.3

import PackageDescription

let package = Package(
    name: "Extensions",
    platforms: [
        .iOS(.v14)
    ],
    products: [
        .library(name: "Extensions", targets: ["Extensions"]),
    ],
    dependencies: [
        .package(path: "../Shared/Strings")
    ],
    targets: [
        .target(name: "Extensions", dependencies: ["Strings"]),
        .testTarget(name: "ExtensionsTests", dependencies: ["Extensions"]),
    ]
)
