//
//  SearchServiceImp.swift
//  Data
//
//  Created by 최동호 on 8/29/24.
//  Copyright © 2024 Svanguard. All rights reserved.
//

import Combine
import Common
import Domain

public final class SearchServiceImp: SearchService {
    private let searchNumberRepository: SearchNumberRepository
    private let searchUsersRepository: SearchUsersRepository
    private let getProfileDataRepository: GetProfileDataRepository
    
    public init(
        searchNumberRepository: SearchNumberRepository,
        searchUsersRepository: SearchUsersRepository,
        getProfileDataRepository: GetProfileDataRepository
    ) {
        self.searchNumberRepository = searchNumberRepository
        self.searchUsersRepository = searchUsersRepository
        self.getProfileDataRepository = getProfileDataRepository
    }
    
    public func searchNumberToServer(request: SearchNumberRequest) -> AnyPublisher<(PunishResultType, String), Error> {
           return searchNumberRepository.searchNumber(request: request)
               .map { response in
                   let resultType: PunishResultType
                   let punishDate: String
                   
                   switch response.punishType {
                   case "restriction":
                       resultType = .restriction
                       punishDate = response.punishDate
                   case "protection":
                       resultType = .protection
                       punishDate = response.punishDate
                   default:
                       if response.registerFg {
                           resultType = .success
                       } else {
                           resultType = .clean
                       }
                       punishDate = ""
                   }
                   
                   return (resultType, punishDate)
               }
               .eraseToAnyPublisher()
       }

       public func searchNumberToSudden(request: GetProfileRequest) -> AnyPublisher<SearchUserData, Error> {
           return getProfileDataRepository.getProfileData(request: request)
               .map { response in
                   return SearchUserData(
                       suddenNumber: request.suddenNumber,
                       userName: response.userName,
                       userImage: response.userImage
                   )
               }
               .eraseToAnyPublisher()
       }

       public func searchUsers(request: SearchUsersRequest) -> AnyPublisher<[SearchUserData], Error> {
           return searchUsersRepository.searchUsers(request: request)
               .map { response in
                   return response.map { userResponse in
                       SearchUserData(
                           suddenNumber: userResponse.suddenNumber,
                           userName: userResponse.userName,
                           userImage: userResponse.userImage
                       )
                   }
               }
               .eraseToAnyPublisher()
       }
}
