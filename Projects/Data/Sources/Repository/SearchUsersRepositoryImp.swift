//
//  SearchUsersRepositoryImp.swift
//  Data
//
//  Created by 최동호 on 8/24/24.
//  Copyright © 2024 Svanguard. All rights reserved.
//

import Domain
import NetworkService
import Foundation

public struct SearchUsersRepositoryImp: SearchUsersRepository {
    let apiClientService: ApiClientService
    
    public init(apiClientService: ApiClientService) {
        self.apiClientService = apiClientService
    }

    public func searchUsers(request: SearchUsersRequest) async throws -> [SearchUsersResponse] {
        let endPoint = SearchUsersEndPoint(request: request)
        
        guard let urlRequest = endPoint.toURLRequest else {
            throw ApiError.errorInUrl
        }
        
        let response: [SearchUsersResponse] = try await apiClientService.request(request: urlRequest, type: SearchUsersDTO.self).toDomain()
        
        return response
    }
}
