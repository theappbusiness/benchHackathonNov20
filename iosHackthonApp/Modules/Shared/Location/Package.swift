// swift-tools-version:5.3

import PackageDescription

let package = Package(
    name: "Location",
    platforms: [
        .iOS(.v14)
    ],
    products: [
        .library(name: "Location", targets: ["Location"]),
    ],
    targets: [
        .target(name: "Location"),
        .testTarget(name: "LocationTests", dependencies: ["Location"]),
    ]
)
