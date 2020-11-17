// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "AddMeal",
    platforms: [
        .iOS(.v14)
    ],
    products: [
        .library(name: "AddMeal", targets: ["AddMeal"]),
    ],
    dependencies: [
        .package(path: "../Shared/Theming"),
        .package(path: "../Shared/Location"),
        .package(path: "../Shared/Strings"),
        .package(path: "../Shared/Components"),
        .package(path: "../Shared/Extensions"),
        .package(name: "shared", path: "../../../../shared/swiftpackage")
    ],
    targets: [
        .target(name: "AddMeal", dependencies: ["shared", "Theming", "Location", "Strings", "Components", "Extensions"]),
        .testTarget(name: "AddMealTests", dependencies: ["AddMeal"]),
    ]
)
