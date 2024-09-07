//
//  SearchNumberRepository.swift
//  Domain
//
//  Created by 최동호 on 8/18/24.
//  Copyright © 2024 Svanguard. All rights reserved.
//

import Combine

public protocol SearchNumberRepository {
    func searchNumber(request: SearchNumberRequest) -> AnyPublisher<SearchNumberResponse, Error>
}

