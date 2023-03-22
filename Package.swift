// swift-tools-version: 5.7

import PackageDescription

let package = Package(
    name: "IconLibrary",
    platforms: [.macOS("10.15"), .iOS(.v14)],
    products: [
        .library(name: "IconLibrary", targets: ["IconLibrary"])
    ],
    targets: [
        .target(name: "IconLibrary", plugins: ["AssetConstants"]),
        .plugin(name: "AssetConstants", capability: .buildTool(), dependencies: ["AssetConstantsExec"]),
        .executableTarget(name: "AssetConstantsExec")
    ]
)
