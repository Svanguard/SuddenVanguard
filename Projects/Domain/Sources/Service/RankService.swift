//
//  RankService.swift
//  Domain
//
//  Created by 최동호 on 8/29/24.
//  Copyright © 2024 Svanguard. All rights reserved.
//

import Combine
import Common

public protocol RankService {
    func loadRankData(period: RankPeriod) -> AnyPublisher<([RankUser], Bool), Error>
    func refreshRankData(period: RankPeriod) -> AnyPublisher<([RankUser], Bool), Error>
    func loadMoreRankData(period: RankPeriod) -> AnyPublisher<([RankUser], Bool), Error>
    func getPunishData(request: SearchNumberRequest) -> AnyPublisher<(PunishResultType, String), Error>
}
