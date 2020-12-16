// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
  name: "Location",
  platforms: [
    .iOS(.v14)
  ], products: [
    .library(
      name: "Location",
      targets: ["Location"])
  ],
  dependencies: [],
  targets: [
    .target(
      name: "Location",
      dependencies: [])
  ]
)
