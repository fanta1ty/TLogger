// swift-tools-version: 5.7

import PackageDescription

let package = Package(
    name: "Logger",
    platforms: [.iOS(.v11)],
    products: [
        .library(
            name: "Logger",
            targets: ["Logger"]),
        .library(
            name: "ConsoleLogHandler",
            targets: ["ConsoleLogHandler"]
        ),
    ],
    dependencies: [
        .package(url: "https://github.com/apple/swift-log.git",
                 from: "1.4.2"),
        .package(url: "https://github.com/DataDog/dd-sdk-ios.git",
                 from: "1.9.0")
    ],
    targets: [
        .target(
            name: "Logger",
            dependencies: [
                .product(name: "Logging", package: "swift-log")
            ]),
        .target(
            name: "ConsoleLogHandler",
            dependencies: [
                "Logger",
            ]
        )
    ]
)
