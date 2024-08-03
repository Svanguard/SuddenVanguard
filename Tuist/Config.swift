//
//  Config.swift
//  Packages
//
//  Created by 최동호 on 8/3/24.
//

import ProjectDescription

let config = Config(
    compatibleXcodeVersions: .all,
    plugins: [
        .local(path: .relativeToRoot("Plugins/EnvironmentPlugin")),
        .local(path: .relativeToRoot("Plugins/DependencyPlugin"))
    ],
    generationOptions: .options()
)
