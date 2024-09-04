//
//  SearchUseCaseImp.swift
//  Domain
//
//  Created by 최동호 on 8/29/24.
//  Copyright © 2024 Svanguard. All rights reserved.
//

import Combine

public struct SearchUseCaseImp: SearchUseCase {
    private let service: SearchService
    
    public init(service: SearchService) {
        self.service = service
    }
    
    public func searchNumber(request: SearchNumberRequest) -> AnyPublisher<SearchNumberResponse, Error> {
        return service.searchNumber(request: request).eraseToAnyPublisher()
    }
    
    public func searchUsers(request: SearchUsersRequest) -> AnyPublisher<[SearchUsersResponse], Error> {
         return service.searchUsers(request: request).eraseToAnyPublisher()
     }
}
