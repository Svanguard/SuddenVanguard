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
   
    )
    
    public static let frameworkInfoPlist: Self = .extendingDefault(
        with: .framework
     
    )
}

public extension [String: Plist.Value] {
    static let baseInfoPlist: Self = [
        "UISupportedInterfaceOrientations":
            [
                "UIInterfaceOrientationPortrait",
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
