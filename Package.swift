// swift-tools-version:5.7
import PackageDescription

let package = Package(
    name: "Nimble",
    platforms: [
      .macOS(.v10_15), .iOS(.v13), .tvOS(.v13), .watchOS(.v6)
    ],
    products: [
        .library(
            name: "Nimble",
            targets: ["Nimble"]
        ),
    ],
    dependencies: [
        .package(url: "https://github.com/mattgallagher/CwlPreconditionTesting.git", .upToNextMajor(from: "2.1.0")),
    ],
    targets: [
        .target(
            name: "Nimble",
            dependencies: [
                .product(name: "CwlPreconditionTesting", package: "CwlPreconditionTesting",
                         condition: .when(platforms: [.macOS, .iOS, .macCatalyst])),
                .product(name: "CwlPosixPreconditionTesting", package: "CwlPreconditionTesting",
                         condition: .when(platforms: [.tvOS, .watchOS]))
            ],
            exclude: ["Info.plist"]
        ),
        .target(
            name: "NimbleSharedTestHelpers",
            dependencies: ["Nimble"]
        ),
        .testTarget(
            name: "NimbleTests",
            dependencies: ["Nimble", "NimbleSharedTestHelpers"],
            exclude: ["Info.plist"]
        ),
    ],
    swiftLanguageVersions: [.v5]
)
