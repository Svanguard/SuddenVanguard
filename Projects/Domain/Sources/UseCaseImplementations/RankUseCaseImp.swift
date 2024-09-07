//
//  RankUseCaseImp.swift
//  Domain
//
//  Created by 최동호 on 8/29/24.
//  Copyright © 2024 Svanguard. All rights reserved.
//

import Combine
import Common

public struct RankUseCaseImp: RankUseCase {
    private let rankService: RankService
    
    public init(rankService: RankService) {
        self.rankService = rankService
    }
    
    public func loadRankData(period: RankPeriod) -> AnyPublisher<([RankUser], Bool), Error> {
        return rankService.loadRankData(period: period)
    }
    
    public func refreshRankData(period: RankPeriod) -> AnyPublisher<([RankUser], Bool), Error> {
        return rankService.refreshRankData(period: period)
    }
    
    public func loadMoreRankData(period: RankPeriod) -> AnyPublisher<([RankUser], Bool), Error> {
        return rankService.loadMoreRankData(period: period)
    }
    
    public func getPunishData(request: SearchNumberRequest) -> AnyPublisher<(PunishResultType, String), Error> {
        return rankService.getPunishData(request: request)
    }
}
