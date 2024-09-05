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
    
    public func getPunishData(request: SearchNumberRequest) -> AnyPublisher<(PunishResultType, String), Error> {
        return rankService.getPunishData(request: request)
    }
    
    public func getRankData(request: RankRequest) -> AnyPublisher<RankResponse, Error> {
        return rankService.getRankData(request: request)
    }
    
    public func getProfileData(request: GetProfileRequest) -> AnyPublisher<ProfileResponse, Error> {
        return rankService.getProfileData(request: request)
    }
}
