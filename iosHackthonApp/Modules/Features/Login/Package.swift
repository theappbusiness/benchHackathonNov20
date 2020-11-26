// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
	name: "Login",
	platforms: [
		.iOS(.v14)
	],
	products: [
		.library(name: "Login", targets: ["Login"]),
	],
	dependencies: [
		.package(path: "../Shared/Theming"),
		.package(path: "../Shared/Strings"),
		.package(path: "../Shared/Components"),
		.package(path: "../Features/SignUp"),
		.package(path: "../Features/TabBar"),
		.package(name: "shared", path: "../../../../shared/swiftpackage")
	],
	targets: [
		.target(name: "Login", dependencies: ["shared", "Theming", "Strings", "Components", "SignUp", "TabBar"]),
		.testTarget(name: "LoginTests", dependencies: ["Login"]),
	]
)
