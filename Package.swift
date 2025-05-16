// swift-tools-version:5.10
import PackageDescription

let package = Package(
    name: "RKUICore",
    platforms: [
        .iOS(.v14),
        .macCatalyst(.v13),
        .macOS(.v10_15)
    ],
    products: [
        .library(
            name: "RKUICore",
            targets: ["RKUICore"]),
    ],
    targets: [
        .target(
            name: "RKUICore",
            dependencies: []),
    ]
)
