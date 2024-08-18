//
//  SearchRepository.swift
//  Domain
//
//  Created by 최동호 on 8/18/24.
//  Copyright © 2024 Svanguard. All rights reserved.
//

import Foundation

public protocol SearchRepository {
    func searchNickName(
        request: SearchNickNameRequest,
        completion: @escaping(Result<SearchNickNameResponse, Error>) -> Void
    )
}
