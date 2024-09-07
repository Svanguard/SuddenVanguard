//
//  Target+Templates.swift
//  Packages
//
//  Created by 최동호 on 8/3/24.
//

import DependencyPlugin
import EnvironmentPlugin
import ProjectDescription

extension Project {
    public static func makeProject(
        name: String,
        moduleType: ModuleType,
        entitlements: Entitlements? = nil,
        isTestable: Bool = false,
        hasResource: Bool = false,
        appExtensionTarget: [Target] = [],
        packages: [Package] = [],
        dependencies: [TargetDependency]
    ) -> Self {
        var schemes = [Scheme]()
        var targets = [Target]()
        
        switch moduleType {
        case .app:
            let app = appTarget(
                name: name,
                entitlements: entitlements,
                dependencies: dependencies
            )
            targets.append(app)
            schemes.append(.moduleScheme(name: name))
            appExtensionTarget.forEach {
                           targets.append($0)
                       }
            
        case .dynamicFramework, .staticFramework, .feature:
            let framework = frameworkTarget(
                name: name,
                entitlements: entitlements,
                hasResource: hasResource,
                dependencies: dependencies
            )
            targets.append(framework)
        }
        
        return Project(name: name,
                       organizationName: .organizationName,
                       options: .options(
                       defaultKnownRegions: ["en", "ko"],
                       developmentRegion: "ko"
                       ),
                       packages: packages,
                       targets: targets,
                       schemes: schemes
               )
    }
    
    private static func appTarget(
        name: String,
        entitlements: Entitlements?,
        dependencies: [TargetDependency]
    ) -> Target {
        let target: Target = .target(
            name: name,
            destinations: .iOS,
            product: .app,
            bundleId: .bundleID + ".\(name)",
            deploymentTargets: .deploymentTarget,
            infoPlist: .appInfoPlist,
            sources: ["Sources/**"],
            resources: ["Resources/**"],
            dependencies: dependencies,
            settings: .appDebug)
        return target
    }
    
    public static func appExtensionTarget(
          name: String,
          plist: InfoPlist?,
          resources: ResourceFileElements? = nil,
          entitlements: Entitlements? = nil,
          dependencies: [TargetDependency]
      ) -> Target {
          let target: Target = .target(
            name: name,
            destinations: .iOS,
            product: .appExtension,
            bundleId: .bundleID + ".\(name)",
            infoPlist: plist,
            sources: ["\(name)/**"],
            resources: resources,
            entitlements: entitlements,
            dependencies: dependencies,
            settings: .settings(
                base: .init()
                    .setCodeSignManual(),
                configurations: [
                    .debug(
                        name: .debug,
                        xcconfig: .relativeToRoot("Config/\(name)_Debug.xcconfig")
                    ),
                    .release(
                        name: .release,
                        xcconfig: .relativeToRoot("Config/\(name)_Release.xcconfig")
                    ),
                ])
          )
          return target
      }
    
    private static func frameworkTarget(
        name: String,
        entitlements: Entitlements?,
        hasResource: Bool,
        dependencies: [TargetDependency]
    ) -> Target {
        let target: Target = .target(
            name: name,
            destinations: .iOS,
            product: .framework,
            bundleId: .bundleID + ".\(name)",
            deploymentTargets: .deploymentTarget,
            infoPlist: .frameworkInfoPlist,
            sources: ["Sources/**"],
            resources: hasResource ? ["Resources/**"] : nil,
            dependencies: dependencies,
            settings: .frameworkDebug)
        return target
    }
}
