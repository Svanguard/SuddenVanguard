//
//  RankPeriod.swift
//  RankFeature
//
//  Created by 강치우 on 8/30/24.
//  Copyright © 2024 Svanguard. All rights reserved.
//

import Foundation

enum RankPeriod: String, CaseIterable {
    case daily
    case weekly
    case monthly
    
    var displayName: String {
        switch self {
        case .daily:
            return "일간"
        case .weekly:
            return "주간"
        case .monthly:
            return "월간"
        }
    }
}
