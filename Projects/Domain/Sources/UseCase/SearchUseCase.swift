//
//  SearchUseCase.swift
//  Domain
//
//  Created by 최동호 on 8/29/24.
//  Copyright © 2024 Svanguard. All rights reserved.
//

import Combine

public protocol SearchUseCase {
    func searchNumber(request: SearchNumberRequest) -> AnyPublisher<SearchNumberResponse, Error>

    func searchUsers(request: SearchUsersRequest) -> AnyPublisher<[SearchUsersResponse], Error>
}
