//
//  SearchService.swift
//  Domain
//
//  Created by 최동호 on 8/29/24.
//  Copyright © 2024 Svanguard. All rights reserved.
//

import Combine
import Common

public protocol SearchService {
    func searchNumberToServer(request: SearchNumberRequest) -> AnyPublisher<(PunishResultType, String), Error>
    
    func searchNumberToSudden(request: GetProfileRequest) -> AnyPublisher<SearchUserData, Error>

    func searchUsers(request: SearchUsersRequest) -> AnyPublisher<[SearchUserData], Error>
}
