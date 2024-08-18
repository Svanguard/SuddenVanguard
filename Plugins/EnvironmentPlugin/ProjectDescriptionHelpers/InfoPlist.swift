//
//  InfoPlist.swift
//  Packages
//
//  Created by 최동호 on 8/3/24.
//

import ProjectDescription

extension InfoPlist {
    public static let appInfoPlist: Self = .extendingDefault(
        with: .baseInfoPlist
            .merging(.secrets, uniquingKeysWith: { oldValue, newValue in
                newValue
            })
    )
    
    public static let frameworkInfoPlist: Self = .extendingDefault(
        with: .framework
            .merging(.secrets, uniquingKeysWith: { oldValue, newValue in
                newValue
            })
    )
}

public extension [String: Plist.Value] {
    static let secrets: Self = [
        "HOST_VALUE": "$(HOST_VALUE)",
        "PORT_NUMBER": "$(PORT_NUMBER)"
    ]
    
    static let baseInfoPlist: Self = [
        "UISupportedInterfaceOrientations":
            [
                "UIInterfaceOrientationPortrait",
            ],
        "NSAppTransportSecurity":
            [
                "NSAllowsArbitraryLoads": true
            ],
        "UILaunchStoryboardName": "LaunchScreen.storyboard",
        "CFBundleShortVersionString": .shortVersion,
        "CFBundleVersion": .version,
        "CFBundleDisplayName": "$(APP_DISPLAY_NAME)",
    ]
    
    static let framework: Self = [
        "CFBundleDevelopmentRegion": "$(DEVELOPMENT_LANGUAGE)",
        "CFBundleExecutable": "$(EXECUTABLE_NAME)",
        "CFBundleIdentifier": "$(PRODUCT_BUNDLE_IDENTIFIER)",
        "CFBundleInfoDictionaryVersion": "6.0",
        "CFBundleName": "$(PRODUCT_NAME)",
        "CFBundlePackageType": "FMWK",
        "CFBundleShortVersionString": .bundleShortVersionString,
        "CFBundleVersion": .bundleVersion,
    ]
}
