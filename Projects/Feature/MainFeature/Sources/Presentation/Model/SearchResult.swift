//
//  SearchResult.swift
//  MainFeature
//
//  Created by 강치우 on 8/3/24.
//  Copyright © 2024 Svanguard. All rights reserved.
//

import Foundation

struct SearchResult {
    let sheetType: SheetType
    let message: String
}

enum SheetType {
    case success
    case error
    case clean
}
