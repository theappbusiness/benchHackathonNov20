// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
	name: "SignUp",
	platforms: [
		.iOS(.v14)
	],
	products: [
		// Products define the executables and libraries a package produces, and make them visible to other packages.
		.library(
			name: "SignUp",
			targets: ["SignUp"]),
	],
	dependencies: [
		.package(path: "../Shared/Theming"),
		.package(path: "../Shared/Strings"),
		.package(path: "../Shared/Components"),
		.package(name: "shared", path: "../../../../shared/swiftpackage")
	],
	targets: [
		// Targets are the basic building blocks of a package. A target can define a module or a test suite.
		// Targets can depend on other targets in this package, and on products in packages this package depends on.
		.target(
			name: "SignUp",
			dependencies: ["shared", "Theming", "Strings", "Components"]),
		.testTarget(
			name: "SignUpTests",
			dependencies: ["SignUp"]),
	]
)
