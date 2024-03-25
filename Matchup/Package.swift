// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Matchup",
    platforms: [.iOS(.v17)],
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(name: "Matchup", targets: ["Matchup"]),
    ],
    dependencies: [
        .package(path: "../Team"),
        .package(path: "../ThemeKit"),
        .package(url: "https://github.com/kean/Nuke.git", from: "12.4.0")
    ],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .target(
            name: "Matchup",
            dependencies: [
                .byName(name: "Team"),
                .byName(name: "ThemeKit"),
                .product(name: "NukeUI", package: "Nuke")
            ]
        ),
        .testTarget(name: "MatchupTests", dependencies: ["Matchup"]),
    ]
)
