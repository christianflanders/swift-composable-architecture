// swift-tools-version:5.9

import CompilerPluginSupport
import PackageDescription

let package = Package(
  name: "swift-composable-architecture",
  platforms: [
    .iOS(.v13),
    .macOS(.v10_15),
    .tvOS(.v13),
    .watchOS(.v6),
  ],
  products: [
    .library(
      name: "ComposableArchitecture",
      targets: ["ComposableArchitecture"]
    )
  ],
  dependencies: [
    .package(url: "https://github.com/apple/swift-collections", from: "1.1.0"),
    .package(url: "https://github.com/google/swift-benchmark", from: "0.1.0"),
    .package(url: "https://github.com/pointfreeco/combine-schedulers", from: "1.0.2"),
    .package(url: "https://github.com/christianflanders/swift-case-paths", branch: "main"),
    .package(url: "https://github.com/pointfreeco/swift-concurrency-extras", from: "1.1.0"),
    .package(url: "https://github.com/pointfreeco/swift-custom-dump", from: "1.3.2"),
    .package(url: "https://github.com/christianflanders/swift-dependencies", branch: "main"),
    .package(url: "https://github.com/pointfreeco/swift-identified-collections", from: "1.1.0"),
    .package(url: "https://github.com/christianflanders/swift-macro-testing", branch: "main"),
    .package(url: "https://github.com/pointfreeco/swift-navigation", from: "2.1.0"),
    .package(url: "https://github.com/christianflanders/swift-perception", branch: "main"),
    .package(url: "https://github.com/pointfreeco/xctest-dynamic-overlay", from: "1.3.0"),
    .package(url: "https://github.com/swiftlang/swift-docc-plugin", from: "1.0.0"),
    .package(url: "https://github.com/sjavora/swift-syntax-xcframeworks.git", from: "510.0.1"),
  ],
  targets: [
    .target(
      name: "ComposableArchitecture",
      dependencies: [
        "ComposableArchitectureMacros",
        .product(name: "CasePaths", package: "swift-case-paths"),
        .product(name: "CombineSchedulers", package: "combine-schedulers"),
        .product(name: "ConcurrencyExtras", package: "swift-concurrency-extras"),
        .product(name: "CustomDump", package: "swift-custom-dump"),
        .product(name: "Dependencies", package: "swift-dependencies"),
        .product(name: "DependenciesMacros", package: "swift-dependencies"),
        .product(name: "IdentifiedCollections", package: "swift-identified-collections"),
        .product(name: "IssueReporting", package: "xctest-dynamic-overlay"),
        .product(name: "OrderedCollections", package: "swift-collections"),
        .product(name: "Perception", package: "swift-perception"),
        .product(name: "SwiftUINavigation", package: "swift-navigation"),
        .product(name: "UIKitNavigation", package: "swift-navigation"),
      ],
      resources: [
        .process("Resources/PrivacyInfo.xcprivacy")
      ]
    ),
    .testTarget(
      name: "ComposableArchitectureTests",
      dependencies: [
        "ComposableArchitecture",
        .product(name: "IssueReportingTestSupport", package: "xctest-dynamic-overlay"),
      ]
    ),
    .macro(
      name: "ComposableArchitectureMacros",
      dependencies: [
          .product(name: "SwiftSyntaxWrapper", package: "swift-syntax-xcframeworks"),
      ]
    ),
    .testTarget(
      name: "ComposableArchitectureMacrosTests",
      dependencies: [
        "ComposableArchitectureMacros",
        .product(name: "MacroTesting", package: "swift-macro-testing"),
      ]
    ),
    .executableTarget(
      name: "swift-composable-architecture-benchmark",
      dependencies: [
        "ComposableArchitecture",
        .product(name: "Benchmark", package: "swift-benchmark"),
      ]
    ),
  ]
)

#if compiler(>=6)
  for target in package.targets where target.type != .system && target.type != .test {
    target.swiftSettings = target.swiftSettings ?? []
    target.swiftSettings?.append(contentsOf: [
      .enableExperimentalFeature("StrictConcurrency"),
      .enableUpcomingFeature("ExistentialAny"),
      .enableUpcomingFeature("InferSendableFromCaptures"),
    ])
  }
#endif
