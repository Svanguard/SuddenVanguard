//
//  Project.swift
//  ProjectDescriptionHelpers
//
//  Created by 최동호 on 8/4/24.
//

import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.makeProject(
    name: "RankFeature",
    moduleType: .feature,
    dependencies: [
        .featureDependency,
    ]
)
