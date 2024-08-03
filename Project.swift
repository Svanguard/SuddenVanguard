import ProjectDescription

let project = Project(
    name: "SuddenVanguard",
    targets: [
        .target(
            name: "SuddenVanguard",
            destinations: .iOS,
            product: .app,
            bundleId: "io.tuist.Tmp",
            infoPlist: .extendingDefault(
                with: [
                    "UILaunchStoryboardName": "LaunchScreen.storyboard",
                ]
            ),
            sources: ["SuddenVanguard/Sources/**"],
            resources: ["SuddenVanguard/Resources/**"],
            dependencies: []
        ),
        .target(
            name: "SuddenVanguardTests",
            destinations: .iOS,
            product: .unitTests,
            bundleId: "io.tuist.SuddenVanguardTests",
            infoPlist: .default,
            sources: ["SuddenVanguard/Tests/**"],
            resources: [],
            dependencies: [.target(name: "SuddenVanguard")]
        ),
    ]
)
