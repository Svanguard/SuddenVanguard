//
//  RankUseCaseImp.swift
//  Domain
//
//  Created by 최동호 on 8/29/24.
//  Copyright © 2024 Svanguard. All rights reserved.
//

import Combine

public struct RankUseCaseImp: RankUseCase {
    private let rankService: RankService
    
    public init(rankService: RankService) {
        self.rankService = rankService
    }
    
    public func getPunishData(request: SearchNumberRequest) -> AnyPublisher<SearchNumberResponse, Error> {
        rankService.getPunishData(request: request).eraseToAnyPublisher()
    }
    
    public func getRankData(request: RankRequest) -> AnyPublisher<RankResponse, Error> {
        rankService.getRankData(request: request)
    }
    
    public func getProfileData(request: GetProfileRequest) -> AnyPublisher<ProfileResponse, Error> {
        rankService.getProfileData(request: request)
    }
}
