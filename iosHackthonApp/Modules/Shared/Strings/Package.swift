// swift-tools-version:5.3

import PackageDescription

let package = Package(
    name: "Strings",
    products: [
        .library(name: "Strings", targets: ["Strings"]),
    ],
    targets: [
        .target(name: "Strings"),
        .testTarget(name: "StringsTests", dependencies: ["Strings"]),
    ]
)
