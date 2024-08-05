//
//  SearchNickNameDTO.swift
//  ProjectDescriptionHelpers
//
//  Created by 최동호 on 8/5/24.
//

import Domain
import Foundation

public struct SearchNickNameDTO: Decodable {
    public let userNumber: String
    public let nickName: String
    
    enum CodingKeys: String, CodingKey {
        case userNumber = "user_nexon_sn"
        case nickName = "user_nick"
    }
}
