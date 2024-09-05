//
//  SearchUseCaseImp.swift
//  Domain
//
//  Created by 최동호 on 8/29/24.
//  Copyright © 2024 Svanguard. All rights reserved.
//

import Combine
import Common

public struct SearchUseCaseImp: SearchUseCase {
    private let service: SearchService
    
    public init(service: SearchService) {
        self.service = service
    }
    
    public func searchNumberToServer(suddenNumber: Int) -> AnyPublisher<(PunishResultType, String), Error> {
          return service.searchNumberToServer(request: .init(suddenNumber: suddenNumber))
      }
      
      public func searchNumberToSudden(suddenNumber: Int) -> AnyPublisher<SearchUserData, Error> {
          return service.searchNumberToSudden(request: .init(suddenNumber: suddenNumber))
      }
      
      public func searchUsers(userName: String) -> AnyPublisher<[SearchUserData], Error> {
          return service.searchUsers(request: .init(userName: userName))
      }
}
