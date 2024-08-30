//
//  GetProfileDataRepositoryImp.swift
//  Data
//
//  Created by 최동호 on 8/29/24.
//  Copyright © 2024 Svanguard. All rights reserved.
//

import Domain
import NetworkService
import Foundation

public struct GetProfileDataRepositoryImp: GetProfileDataRepository {
    private let apiClientService: ApiClientService
    
    public init(apiClientService: ApiClientService) {
        self.apiClientService = apiClientService
    }
    
    public func getProfileData(request: GetProfileRequest) async throws -> ProfileResponse {
        let endPoint = ProfileEndPoint(request: request)
        
        guard let urlRequest = endPoint.toURLRequest else {
            throw ApiError.errorInUrl
        }
        
        let response: ProfileResponse = try await apiClientService.request(request: urlRequest, type: ProfileDTO.self).toDomain()
        
        return response
    }
}
