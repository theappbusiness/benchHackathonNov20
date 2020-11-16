// swift-tools-version:5.3

import PackageDescription

let package = Package(
    name: "Components",
    platforms: [
        .iOS(.v14)
    ],
    products: [
        .library(name: "Components", targets: ["Components"])
    ],
    dependencies: [
        .package(path: "../Shared/Theming")
    ],
    targets: [
        .target(name: "Components", dependencies: ["Theming"]),
        .testTarget(name: "ComponentsTests", dependencies: ["Components"]),
    ]
)
