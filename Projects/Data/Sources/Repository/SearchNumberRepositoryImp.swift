//
//  SearchNumberRepositoryImp.swift
//  Data
//
//  Created by 최동호 on 8/18/24.
//  Copyright © 2024 Svanguard. All rights reserved.
//

import Domain
import NetworkService
import Foundation

public struct SearchNumberRepositoryImp: SearchNumberRepository {
    let apiClientService: ApiClientService
    
    public init(apiClientService: ApiClientService) {
        self.apiClientService = apiClientService
    }
    
    public func searchNumber(request: SearchNumberRequest) async throws -> SearchNumberResponse {
        let endPoint = SearchNumberEndPoint(request: request)
        
        guard let urlRequest = endPoint.toURLRequest else {
            throw ApiError.errorInUrl
        }
        
        let response: SearchNumberResponse = try await apiClientService.request(request: urlRequest, type: SearchNumberDTO.self).toDomain()
        
        return response
    }
}