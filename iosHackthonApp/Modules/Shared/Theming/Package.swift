// swift-tools-version:5.3

import PackageDescription

let package = Package(
    name: "Theming",
    platforms: [
        .iOS(.v14)
    ],
    products: [
        .library(name: "Theming", targets: ["Theming"]),
    ],
    targets: [
        .target(name: "Theming"),
        .testTarget(name: "ThemingTests", dependencies: ["Theming"]),
    ]
)
