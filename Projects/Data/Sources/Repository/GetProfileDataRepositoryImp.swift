//
//  GetProfileDataRepositoryImp.swift
//  Data
//
//  Created by 최동호 on 8/29/24.
//  Copyright © 2024 Svanguard. All rights reserved.
//

import Combine
import Domain
import NetworkService

public struct GetProfileDataRepositoryImp: GetProfileDataRepository {
    private let apiClientService: ApiClientService
    
    public init(apiClientService: ApiClientService) {
        self.apiClientService = apiClientService
    }
    
    public func getProfileData(request: GetProfileRequest) -> AnyPublisher<ProfileResponse, Error> {
        let endPoint = ProfileEndPoint(request: request)
        
        guard let urlRequest = endPoint.toURLRequest else {
            return Fail(error: ApiError.errorInUrl).eraseToAnyPublisher()
        }
        
        return apiClientService
            .requestPublisher(request: urlRequest, type: ProfileDTO.self)
            .map { $0.toDomain() }
            .eraseToAnyPublisher()
    }
}
