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
    public let userNexonSn: Int
    public let userNick: String
    public let userImg: String
    
    private enum CodingKeys: String, CodingKey {
        case userNexonSn = "user_nexon_sn"
        case userNick = "user_nick"
        case userImg = "user_img"
    }
}

extension SearchUsersDTO {
    func toDomain() -> [SearchUsersResponse] {
        var tmp: [SearchUsersResponse] = []
        result.characterInfo.forEach { userData in
            let suddenNumber = userData.userNexonSn
            let userName = userData.userNick
            let userImg = userData.userImg
            
            tmp.append(
                .init(
                    suddenNumber: suddenNumber,
                    userName: userName,
                    userImage: userImg
                )
            )
        }
        return tmp
    }
}
