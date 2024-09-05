//
//  RankService.swift
//  Domain
//
//  Created by 최동호 on 8/29/24.
//  Copyright © 2024 Svanguard. All rights reserved.
//

import Combine

public protocol RankService {
    func getPunishData(request: SearchNumberRequest) -> AnyPublisher<SearchNumberResponse, Error>
    func getRankData(request: RankRequest) -> AnyPublisher<RankResponse, Error>
    func getProfileData(request: GetProfileRequest) -> AnyPublisher<ProfileResponse, Error>
}
