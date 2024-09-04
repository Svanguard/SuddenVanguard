//
//  SearchServiceImp.swift
//  Data
//
//  Created by 최동호 on 8/29/24.
//  Copyright © 2024 Svanguard. All rights reserved.
//

import Combine
import Domain

public struct SearchServiceImp: SearchService {
    private let searchNumberRepository: SearchNumberRepository
    private let searchUsersRepository: SearchUsersRepository
    
    public init(
        searchNumberRepository: SearchNumberRepository,
        searchUsersRepository: SearchUsersRepository
    ) {
        self.searchNumberRepository = searchNumberRepository
        self.searchUsersRepository = searchUsersRepository
    }
    
    public func searchNumber(request: SearchNumberRequest) -> AnyPublisher<SearchNumberResponse, Error> {
        return searchNumberRepository.searchNumber(request: request)
    }
    
    public func searchUsers(request: SearchUsersRequest) -> AnyPublisher<[SearchUsersResponse], Error> {
        return searchUsersRepository.searchUsers(request: request)
    }
}
