//
//  RankDataStoreImp.swift
//  Data
//
//  Created by 최동호 on 9/6/24.
//  Copyright © 2024 Svanguard. All rights reserved.
//

import Common
import Domain
import Foundation

public final class RankDataStoreImp: RankDataStore {
    private var dailyResponse: RankResponse = .init(rankDatas: [])
    private var weeklyResponse: RankResponse = .init(rankDatas: [])
    private var monthlyResponse: RankResponse = .init(rankDatas: [])
    
    public init() { }
    // 기간별로 랭크 데이터를 저장
    public func saveRankResponse(response: RankResponse, period: RankPeriod) {
        switch period {
        case .daily:
            dailyResponse = response
        case .weekly:
            weeklyResponse = response
        case .monthly:
            monthlyResponse = response
        }
    }
    
    // 저장된 랭크 데이터를 조회
    public func getRankResponse(period: RankPeriod) -> RankResponse? {
        switch period {
        case .daily:
            return dailyResponse.rankDatas.isEmpty ? nil : dailyResponse
        case .weekly:
            return weeklyResponse.rankDatas.isEmpty ? nil : weeklyResponse
        case .monthly:
            return monthlyResponse.rankDatas.isEmpty ? nil : monthlyResponse
        }
    }
    
    // 특정 기간의 데이터를 초기화
    public func resetRankResponse(period: RankPeriod) {
        switch period {
        case .daily:
            dailyResponse = .init(rankDatas: [])
        case .weekly:
            weeklyResponse = .init(rankDatas: [])
        case .monthly:
            monthlyResponse = .init(rankDatas: [])
        }
    }
}
