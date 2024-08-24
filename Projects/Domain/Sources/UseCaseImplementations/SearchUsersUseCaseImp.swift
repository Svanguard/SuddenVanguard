//
//  SearchUsersUseCaseImp.swift
//  Domain
//
//  Created by 최동호 on 8/24/24.
//  Copyright © 2024 Svanguard. All rights reserved.
//

import Foundation

public struct SearchUsersUseCaseImp: SearchUsersUseCase {
    let searchUsersRepository: SearchUsersRepository
    
    public init(searchUsersRepository: SearchUsersRepository) {
        self.searchUsersRepository = searchUsersRepository
    }
    
    public func searchUsers(request: SearchUsersRequest) async throws -> [SearchUsersResponse] {
        return try await searchUsersRepository.searchUsers(request: request)
    }
}
