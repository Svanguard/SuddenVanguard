//
//  GetRankDataRepositoryImp.swift
//  Data
//
//  Created by 최동호 on 8/29/24.
//  Copyright © 2024 Svanguard. All rights reserved.
//

import Common
import Domain
import NetworkService
import Foundation

public struct GetRankDataRepositoryImp: GetRankDataRepository {
    private let apiClientService: ApiClientService
    
    public init(apiClientService: ApiClientService) {
        self.apiClientService = apiClientService
    }
    
    public func getRankData() async throws -> RankResponse {
        let endPoint = RankEndPoint()
        
        guard let urlRequest = endPoint.toURLRequest else {
            throw ApiError.errorInUrl
        }
        
        let response: RankResponse = try await apiClientService.request(request: urlRequest, type: RankDTO.self).toDomain()
        
        return response
    }
}
