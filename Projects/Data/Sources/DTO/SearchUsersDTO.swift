//
//  SearchUsersDTO.swift
//  Data
//
//  Created by 최동호 on 8/24/24.
//  Copyright © 2024 Svanguard. All rights reserved.
//

import Domain
import Foundation

public struct SearchUsersDTO: Decodable {
    public let rtnCode: Int
    public let message: String?
    public let result: SearchResults
}

public struct SearchResults: Decodable {
    public let characterInfo: [UserData]
    public let total_cnt: Int
    public let page_no: Int
}

public struct UserData: Decodable {
    public let user_nexon_sn: Int
    public let user_nick: String
    public let user_img: String
}

extension SearchUsersDTO {
    func toDomain() -> [SearchUsersResponse] {
        var tmp: [SearchUsersResponse] = []
        result.characterInfo.forEach { userData in
            let suddenNumber = userData.user_nexon_sn
            let userName = userData.user_nick
            let user_img = userData.user_img
            
            tmp.append(
                .init(
                    suddenNumber: suddenNumber,
                    userName: userName,
                    userImage: user_img
                )
            )
        }
        return tmp
    }
}
