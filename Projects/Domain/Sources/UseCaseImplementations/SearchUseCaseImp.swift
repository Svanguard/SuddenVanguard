//
//  SearchUseCaseImp.swift
//  Domain
//
//  Created by 최동호 on 8/29/24.
//  Copyright © 2024 Svanguard. All rights reserved.
//

import Foundation

public struct SearchUseCaseImp: SearchUseCase {
    private let service: SearchService
    
    public init(service: SearchService) {
        self.service = service
    }
    
    public func searchNumber(request: SearchNumberRequest) async throws -> SearchNumberResponse {
        try await service.searchNumber(request: request)
    }
    
    public func searchUsers(request: SearchUsersRequest) async throws -> [SearchUsersResponse] {
        try await service.searchUsers(request: request)
    }
}
