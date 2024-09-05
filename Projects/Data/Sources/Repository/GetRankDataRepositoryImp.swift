//
//  GetRankDataRepositoryImp.swift
//  Data
//
//  Created by 최동호 on 8/29/24.
//  Copyright © 2024 Svanguard. All rights reserved.
//

import Combine
import Domain
import NetworkService

public struct GetRankDataRepositoryImp: GetRankDataRepository {
    private let apiClientService: ApiClientService
    
    public init(apiClientService: ApiClientService) {
        self.apiClientService = apiClientService
    }
    
    public func getRankData(request: RankRequest) -> AnyPublisher<RankResponse, Error> {
        let endPoint = RankEndPoint(request: request)
        
        guard let urlRequest = endPoint.toURLRequest else {
            return Fail(error: ApiError.errorInUrl).eraseToAnyPublisher()
        }
        
        return apiClientService
            .requestPublisher(request: urlRequest, type: RankDTO.self)
            .map { $0.toDomain() }
            .eraseToAnyPublisher()
    }
}
