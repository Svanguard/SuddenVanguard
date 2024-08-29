//
//  RankUseCaseImp.swift
//  Domain
//
//  Created by 최동호 on 8/29/24.
//  Copyright © 2024 Svanguard. All rights reserved.
//

import Foundation

public struct RankUseCaseImp: RankUseCase {
    private let rankService: RankService
    
    public init(rankService: RankService) {
        self.rankService = rankService
    }
    
    public func getRankData() async throws -> RankResponse {
        try await rankService.getRankData()
    }
    
}
