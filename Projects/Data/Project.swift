//
//  Project.swift
//  ProjectDescriptionHelpers
//
//  Created by 최동호 on 8/5/24.
//

import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.makeProject(
    name: "Data",
    moduleType: .dynamicFramework,
    hasResource: false,
    dependencies: [
        .networkService
    ]
)
