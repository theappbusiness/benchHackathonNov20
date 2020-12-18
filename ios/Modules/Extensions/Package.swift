// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
  name: "Extensions",
  platforms: [
    .iOS(.v14)
  ],
  products: [
    .library(
      name: "Extensions",
      targets: ["Extensions"])
  ],
  dependencies: [],
  targets: [
    .target(
      name: "Extensions",
      dependencies: [])
  ]
)
