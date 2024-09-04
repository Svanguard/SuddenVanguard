//
//  SearchNumberRepositoryImp.swift
//  Data
//
//  Created by 최동호 on 8/18/24.
//  Copyright © 2024 Svanguard. All rights reserved.
//

import Combine
import Domain
import NetworkService
import Foundation

public struct SearchNumberRepositoryImp: SearchNumberRepository {
    let apiClientService: ApiClientService
    
    public init(apiClientService: ApiClientService) {
        self.apiClientService = apiClientService
    }
    
    public func searchNumber(request: SearchNumberRequest) -> AnyPublisher<SearchNumberResponse, Error> {
        let endPoint = SearchNumberEndPoint(request: request)
        
        guard let urlRequest = endPoint.toURLRequest else {
            return Fail(error: ApiError.errorInUrl).eraseToAnyPublisher()
        }
        
        return apiClientService.requestPublisher(request: urlRequest, type: SearchNumberDTO.self)
            .map { $0.toDomain() }
            .eraseToAnyPublisher()
    }
}
