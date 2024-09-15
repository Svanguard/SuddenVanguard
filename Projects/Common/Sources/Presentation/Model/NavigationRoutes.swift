//
//  NavigationRoutes.swift
//  Common
//
//  Created by 강치우 on 9/15/24.
//  Copyright © 2024 Svanguard. All rights reserved.
//

import Foundation

// MARK: NavigationPath를 관리하기 위한 enum
public enum MainNavigationRoutes: Hashable {
    case nickname
    case number
}

public enum RankNavigationRoutes: Hashable {
    case resultView(userNick: String, userSuddenNumber: Int)
}

public enum SettingNavigationRoute: Hashable {
    case notice
    case webView(url: URL, title: String)
}
