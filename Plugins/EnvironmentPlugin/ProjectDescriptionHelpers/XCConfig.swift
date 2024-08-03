//
//  XCConfig.swift
//  Packages
//
//  Created by 최동호 on 8/3/24.
//

import ProjectDescription

public extension Settings {
    static let appDebug: Self = .settings(
        base: .baseSetting
            .setVersion()
            .setCodeSignManual()
            .setUserScriptSandboxing()
            .setClangModuleDebugging(),
        configurations: [
            .debug(name: .debug, xcconfig: .relativeToRoot("Config/Debug.xcconfig")),
            .release(name: .release, xcconfig: .relativeToRoot("Config/Release.xcconfig")),
        ],
        defaultSettings: .recommended
    )
    
    static let frameworkDebug: Self = .settings(
        base: .baseSetting
            .setUserScriptSandboxing()
            .setClangModuleDebugging(),
        configurations: [
            .debug(name: .debug, xcconfig: .relativeToRoot("Config/Debug.xcconfig")),
            .release(name: .release, xcconfig: .relativeToRoot("Config/Release.xcconfig")),
        ],
        defaultSettings: .recommended
    )
}

public extension SettingsDictionary {
    static let baseSetting: Self = [
        "OTHER_LDFLAGS" : [
            "$(inherited) -ObjC",
        ]
    ]
    
    func setVersion() -> SettingsDictionary {
        merging(
            [
                "VERSIONING_SYSTEM": .string("apple-generic"),
                "CURRENT_PROJECT_VERSION": .currentProjectVersion,
                "MARKETING_VERSION": .marketingVersion
            ]
        )
    }
    
    func setProvisioning() -> SettingsDictionary {
        merging(
            [
                "PROVISIONING_PROFILE_SPECIFIER": .string("$(APP_PROVISIONING_PROFILE)"),
                "PROVISIONING_PROFILE": .string("$(APP_PROVISIONING_PROFILE)"),
            ]
        )
    }
    
    func setCodeSignManual() -> SettingsDictionary {
        merging(
            [
                "CODE_SIGN_STYLE": .string("Manual"),
//                "DEVELOPMENT_TEAM": .string(.teamId),
                "CODE_SIGN_IDENTITY": .string("$(CODE_SIGN_IDENTITY)")
            ]
        )
    }
    
    func setUserScriptSandboxing() -> SettingsDictionary {
        merging(
            [
                "ENABLE_USER_SCRIPT_SANDBOXING": .string("NO"),
            ]
        )
    }
    
    func setClangModuleDebugging() -> SettingsDictionary {
        merging(
            [
                "CLANG_ENABLE_MODULE_DEBUGGING": .string("YES"),
            ]
        )
    }
}
