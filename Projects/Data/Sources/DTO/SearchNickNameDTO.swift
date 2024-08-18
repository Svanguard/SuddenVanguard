//
//  SearchNickNameDTO.swift
//  ProjectDescriptionHelpers
//
//  Created by 최동호 on 8/5/24.
//

import Domain
import Foundation

public struct SearchNickNameDTO: Decodable {
    public let resultCode: Int
    public let resultMsg: String
    public let resultData: UserDTO
}

public struct UserDTO: Decodable {
    public let userNexonSn: Int
    public let userNick: String
    public let punishType: String
    public let punishDate: String
    public let registerFg: Bool
    
    enum CodingKeys: String, CodingKey {
        case userNexonSn = "userNexonSn"
        case userNick = "userNick"
        case punishType = "punishType"
        case punishDate = "punishDate"
        case registerFg = "registerFg"
    }
}

extension SearchNickNameDTO {
    func toDomain() -> SearchNickNameResponse {
        return SearchNickNameResponse(
            suddenNumber: resultData.userNexonSn,
            userName: resultData.userNick,
            punishType: resultData.punishType,
            punishDate: resultData.punishDate,
            registerFg: resultData.registerFg
        )
    }
}
