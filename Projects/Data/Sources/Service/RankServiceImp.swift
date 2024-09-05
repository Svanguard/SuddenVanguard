//
//  RankServiceImp.swift
//  Data
//
//  Created by 최동호 on 8/29/24.
//  Copyright © 2024 Svanguard. All rights reserved.
//

import Combine
import Domain

public struct RankServiceImp: RankService {
    private let searchNumberRepository: SearchNumberRepository
    private let getRankDataRepository: GetRankDataRepository
    private let getProfileDataRepository: GetProfileDataRepository
    
    public init(
        searchNumberRepository: SearchNumberRepository,
        getRankDataRepository: GetRankDataRepository,
        getProfileDataRepository: GetProfileDataRepository
    ) {
        self.searchNumberRepository = searchNumberRepository
        self.getRankDataRepository = getRankDataRepository
        self.getProfileDataRepository = getProfileDataRepository
    }
    
    public func getPunishData(request: Domain.SearchNumberRequest) -> AnyPublisher<Domain.SearchNumberResponse, Error> {
        searchNumberRepository.searchNumber(request: request)
    }
    
    public func getRankData(request: RankRequest) -> AnyPublisher<RankResponse, Error> {
        getRankDataRepository.getRankData(request: request)
    }

    public func getProfileData(request: GetProfileRequest) -> AnyPublisher<ProfileResponse, Error> {
        getProfileDataRepository.getProfileData(request: request)
    }
}
