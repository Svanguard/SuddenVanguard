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
    private let getRankDataRepository: GetRankDataRepository
    private let getProfileDataRepository: GetProfileDataRepository
    
    public init(
        getRankDataRepository: GetRankDataRepository,
        getProfileDataRepository: GetProfileDataRepository
    ) {
        self.getRankDataRepository = getRankDataRepository
        self.getProfileDataRepository = getProfileDataRepository
    }
    
    public func getRankData(request: RankRequest) -> AnyPublisher<RankResponse, Error> {
        getRankDataRepository.getRankData(request: request)
    }

    public func getProfileData(request: GetProfileRequest) -> AnyPublisher<ProfileResponse, Error> {
        getProfileDataRepository.getProfileData(request: request)
    }
}
