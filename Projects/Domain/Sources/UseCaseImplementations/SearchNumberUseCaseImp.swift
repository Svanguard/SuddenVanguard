//
//  SearchNumberUseCaseImp.swift
//  Domain
//
//  Created by 최동호 on 8/18/24.
//  Copyright © 2024 Svanguard. All rights reserved.
//

import Foundation

public struct SearchNumberUseCaseImp: SearchNumberUseCase {
    let searchNumberRepository: SearchNumberRepository
    
    public init(searchNumberRepository: SearchNumberRepository) {
        self.searchNumberRepository = searchNumberRepository
    }
    
    public func searchNumber(request: SearchNumberRequest) async throws -> SearchNumberResponse {
        try await searchNumberRepository.searchNumber(request: request)
    }
}
