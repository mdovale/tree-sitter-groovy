// swift-tools-version:5.3

import PackageDescription

let package = Package(
    name: "TreeSitterGroovy",
    products: [
        .library(name: "TreeSitterGroovy", targets: ["TreeSitterGroovy"]),
    ],
    dependencies: [
        .package(name: "SwiftTreeSitter", url: "https://github.com/tree-sitter/swift-tree-sitter", from: "0.9.0"),
    ],
    targets: [
        .target(
            name: "TreeSitterGroovy",
            dependencies: [],
            path: ".",
            exclude: [
                "binding.gyp",
                "bindings/c",
                "bindings/go",
                "bindings/node",
                "bindings/python",
                "bindings/rust",
                "bindings/swift/TreeSitterGroovyTests",
                "Cargo.toml",
                "Cargo.lock",
                "CONTRIBUTING.md",
                "LICENSE",
                "Makefile",
                "grammar.js",
                "package-lock.json",
                "package.json",
                "pyproject.toml",
                "README.md",
                "setup.py",
                "src/grammar.json",
                "src/node-types.json",
                "test",
                "treesexpy",
                "tmp_pipeline",
                "test_pipeline",
                "test_pipeline_2",
                "test_pipeline_3",
                "test.groovy",
                "test.js",
                "tree-sitter.json",
                ".editorconfig",
                ".github",
                ".gitignore",
                ".gitattributes",
                ".python-version",
            ],
            sources: [
                "src/parser.c",
            ],
            resources: [
                .copy("queries"),
            ],
            publicHeadersPath: "bindings/swift",
            cSettings: [.headerSearchPath("src")],
        ),
        .testTarget(
            name: "TreeSitterGroovyTests",
            dependencies: [
                "SwiftTreeSitter",
                "TreeSitterGroovy",
            ],
            path: "bindings/swift/TreeSitterGroovyTests",
        ),
    ],
    cLanguageStandard: .c11,
)
