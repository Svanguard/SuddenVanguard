//
//  SearchUseCaseImp.swift
//  Domain
//
//  Created by 최동호 on 8/18/24.
//  Copyright © 2024 Svanguard. All rights reserved.
//

import Foundation

public struct SearchUseCaseImp: SearchUseCase {
    let searchRepository: SearchRepository
    
    public init(searchRepository: SearchRepository) {
        self.searchRepository = searchRepository
    }
    
    public func searchNickName(
        request: SearchNickNameRequest,
        completion: @escaping (Result<SearchNickNameResponse, Error>) -> Void
    ) {
        searchRepository.searchNickName(
            request: request,
            completion: completion
        )
    }
}
