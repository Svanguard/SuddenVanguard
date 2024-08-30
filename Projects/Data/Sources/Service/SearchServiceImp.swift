//
//  SearchServiceImp.swift
//  Data
//
//  Created by 최동호 on 8/29/24.
//  Copyright © 2024 Svanguard. All rights reserved.
//

import Domain
import Foundation

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
    
    public func searchNumber(request: SearchNumberRequest) async throws -> SearchNumberResponse {
        try await searchNumberRepository.searchNumber(request: request)
    }
    
    public func searchUsers(request: SearchUsersRequest) async throws -> [SearchUsersResponse] {
        try await searchUsersRepository.searchUsers(request: request)
    }

}
