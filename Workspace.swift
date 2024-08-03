//
//  Workspace.swift
//  Packages
//
//  Created by 최동호 on 8/3/24.
//

import DependencyPlugin
import EnvironmentPlugin
import ProjectDescription

let workspace = Workspace(
    name: .appName,
    projects: [
        "Projects/**",
    ],
    additionalFiles: [
          "README.md",
      ]
)
