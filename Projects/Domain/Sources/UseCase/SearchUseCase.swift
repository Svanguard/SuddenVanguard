//
//  SearchUseCase.swift
//  Domain
//
//  Created by 최동호 on 8/29/24.
//  Copyright © 2024 Svanguard. All rights reserved.
//

import Common
import Combine

public protocol SearchUseCase {
    func searchNumberToServer(suddenNumber: Int) -> AnyPublisher<(PunishResultType, String), Error>
    
    func searchNumberToSudden(suddenNumber: Int) -> AnyPublisher<SearchUserData, Error>

    func searchUsers(userName: String) -> AnyPublisher<[SearchUserData], Error> 
}
