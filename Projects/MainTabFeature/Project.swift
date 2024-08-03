//
//  Project.swift
//  ProjectDescriptionHelpers
//
//  Created by 최동호 on 8/3/24.
//

import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.makeProject(
    name: "MainTabFeature",
    moduleType: .feature,
    dependencies: .Presentation.allCases.map { $0.dependency }
)

