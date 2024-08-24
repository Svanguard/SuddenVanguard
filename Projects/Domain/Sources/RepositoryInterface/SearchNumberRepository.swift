//
//  SearchNumberRepository.swift
//  Domain
//
//  Created by 최동호 on 8/18/24.
//  Copyright © 2024 Svanguard. All rights reserved.
//

import Foundation

public protocol SearchNumberRepository {
    func searchNumber(
        request: SearchNumberRequest,
        completion: @escaping(Result<SearchNumberResponse, Error>) -> Void
    )
}
