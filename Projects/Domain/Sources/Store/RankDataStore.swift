//
//  RankDataStore.swift
//  Domain
//
//  Created by 최동호 on 9/6/24.
//  Copyright © 2024 Svanguard. All rights reserved.
//

import Common
import Foundation

public protocol RankDataStore {
    func saveRankResponse(response: RankResponse, period: RankPeriod)
    func getRankResponse(period: RankPeriod) -> RankResponse?
    func resetRankResponse(period: RankPeriod)
}
