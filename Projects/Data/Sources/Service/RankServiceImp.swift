//
//  RankServiceImp.swift
//  Data
//
//  Created by 최동호 on 8/29/24.
//  Copyright © 2024 Svanguard. All rights reserved.
//

import Domain
import Foundation

public struct RankServiceImp: RankService {
    private let repository: GetRankDataRepository
    
    public init(repository: GetRankDataRepository) {
        self.repository = repository
    }
    
    public func getRankData() async throws -> RankResponse {
        try await repository.getRankData()
    }

}
