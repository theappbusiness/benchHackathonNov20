// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
  name: "Strings",
  products: [
    .library(
      name: "Strings",
      targets: ["Strings"])
  ],
  dependencies: [],
  targets: [
    .target(
      name: "Strings",
      dependencies: []),
    .testTarget(
      name: "StringsTests",
      dependencies: ["Strings"])
  ]
)
