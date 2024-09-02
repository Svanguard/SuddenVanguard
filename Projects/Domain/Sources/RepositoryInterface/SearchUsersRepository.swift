//
//  SearchUsersRepository.swift
//  Domain
//
//  Created by 최동호 on 8/24/24.
//  Copyright © 2024 Svanguard. All rights reserved.
//

import Foundation

public protocol SearchUsersRepository {
    func searchUsers(request: SearchUsersRequest) async throws -> [SearchUsersResponse]
}