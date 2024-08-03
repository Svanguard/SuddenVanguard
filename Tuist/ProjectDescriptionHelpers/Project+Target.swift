//
//  Project+Target.swift
//  Packages
//
//  Created by 최동호 on 8/3/24.
//

import ProjectDescription

public enum ModuleType {
    case app, dynamicFramework, staticFramework, feature
    
    var product: Product {
        switch self {
        case .app:
            return .app
        case .dynamicFramework:
            return .framework
        case .staticFramework, .feature:
            return .staticFramework
        }
    }
}
