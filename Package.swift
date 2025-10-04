// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "LWProgressViewSwift",
    platforms: [
        .iOS(.v13)
    ],
    products: [
        .library(
            name: "LWProgressViewSwift",
            targets: ["LWProgressViewSwift"]),
    ],
    dependencies: [
        // No external dependencies
    ],
    targets: [
        .target(
            name: "LWProgressViewSwift",
            dependencies: [],
            path: "LWProgressView/Classes",
            exclude: [
                "LWMaskProgressView.h",
                "LWMaskProgressView.m",
                "UsageExamples.swift"  // Exclude examples from package
            ],
            sources: [
                "CircleProgressBar.swift",
                "LWMaskProgressView.swift",
                "LWProgressViewModifier.swift"
            ]
        )
    ],
    swiftLanguageVersions: [.v5]
)
