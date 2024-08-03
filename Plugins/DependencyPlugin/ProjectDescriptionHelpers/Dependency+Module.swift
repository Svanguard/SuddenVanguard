//
//  Dependency+Module.swift
//  Packages
//
//  Created by 최동호 on 8/3/24.
//

import ProjectDescription

public extension TargetDependency {
    static let app: Self = .module(name: "App")
    static let mainTabFeature: Self = .module(name: "MainTabFeature")
    static let featureDependency: Self = .module(name: "FeatureDependency")
    static let common: Self = .module(name: "Common")
    static let core: Self = .module(name: "Core")
    static let data: Self = .module(name: "Data")
    static let domain: Self = .module(name: "Domain")
    static let networkService: Self = .module(name: "NetworkService")
    static let designSystem: Self = .module(name: "DesignSystem")
    
    private static func module(name: String) -> Self {
        .project(target: name, path: .relativeToRoot("Projects/\(name)"))
    }
    
    private static func moduleWithAdditionalPath(name: String, path: String) -> Self {
        .project(target: name, path: .relativeToRoot("Projects/\(path)/\(name)"))
    }
}
