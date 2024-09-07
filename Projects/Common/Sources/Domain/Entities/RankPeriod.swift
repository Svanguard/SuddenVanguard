//
//  RankPeriod.swift
//  Common
//
//  Created by 최동호 on 9/6/24.
//  Copyright © 2024 Svanguard. All rights reserved.
//

import Foundation

public enum RankPeriod: String, CaseIterable {
    case daily
    case weekly
    case monthly
    
    public var displayName: String {
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
