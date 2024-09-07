//
//  SearchUsersRepositoryImp.swift
//  Data
//
//  Created by 최동호 on 8/24/24.
//  Copyright © 2024 Svanguard. All rights reserved.
//

import Combine
import Domain
import NetworkService

public struct SearchUsersRepositoryImp: SearchUsersRepository {
    let apiClientService: ApiClientService
    
    public init(apiClientService: ApiClientService) {
        self.apiClientService = apiClientService
    }

    public func searchUsers(request: SearchUsersRequest) -> AnyPublisher<[SearchUsersResponse], Error> {
           let endPoint = SearchUsersEndPoint(request: request)
           
           guard let urlRequest = endPoint.toURLRequest else {
               return Fail(error: ApiError.errorInUrl).eraseToAnyPublisher()
           }
           
           return apiClientService.requestPublisher(request: urlRequest, type: SearchUsersDTO.self)
               .map { $0.toDomain() }
               .eraseToAnyPublisher()
       }
}
