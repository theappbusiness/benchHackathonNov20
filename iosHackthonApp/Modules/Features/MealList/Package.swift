// swift-tools-version:5.3

import PackageDescription

let package = Package(
    name: "MealList",
    platforms: [
        .iOS(.v14)
    ],
    products: [
        .library(name: "MealList", targets: ["MealList"]),
    ],
    dependencies: [
        .package(path: "../Shared/Extensions"),
        .package(path: "../Shared/Location"),
        .package(path: "../Shared/Components"),
        .package(name: "shared", path: "../../../../shared/swiftpackage")
    ],
    targets: [
        .target(name: "MealList", dependencies: ["shared", "Extensions", "Location", "Components"]),
        .testTarget(name: "MealListTests", dependencies: ["MealList"]),
    ]
)
