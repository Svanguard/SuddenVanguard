//
//  Project.swift
//  Packages
//
//  Created by 최동호 on 8/3/24.
//

import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.makeProject(
    name: "App",
    moduleType: .app,
    dependencies: [
        .mainTabFeature,
    ]
)
