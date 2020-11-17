// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "TabBar",
    platforms: [
        .iOS(.v14)
    ],
    products: [
        .library(name: "TabBar", targets: ["TabBar"]),
    ],
    dependencies: [
        .package(path: "../Shared/Theming"),
        .package(path: "../Shared/Location"),
        .package(path: "../Shared/Strings"),
        .package(path: "../Features/MealList"),
        .package(path: "../Features/AddMeal"),
        .package(name: "shared", path: "../../../../shared/swiftpackage")
    ],
    targets: [
        .target(name: "TabBar", dependencies: ["shared", "Theming", "Location", "Strings", "MealList", "AddMeal"]),
        .testTarget(name: "TabBarTests", dependencies: ["TabBar"]),
    ]
)
