// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
	name: "SignUp",
	platforms: [
		.iOS(.v14)
	],
	products: [
		.library(name: "SignUp", targets: ["SignUp"]),
	],
	dependencies: [
		.package(path: "../Shared/Theming"),
		.package(path: "../Shared/Strings"),
		.package(path: "../Shared/Components"),
		.package(path: "../Features/TabBar"),
		.package(name: "shared", path: "../../../../shared/swiftpackage")
	],
	targets: [
		.target(name: "SignUp", dependencies: ["shared", "Theming", "Strings", "Components", "TabBar"]),
		.testTarget(name: "SignUpTests", dependencies: ["SignUp"]),
	]
)
