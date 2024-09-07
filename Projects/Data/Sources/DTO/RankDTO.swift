//
//  RankDTO.swift
//  Data
//
//  Created by 최동호 on 8/29/24.
//  Copyright © 2024 Svanguard. All rights reserved.
//

import Domain
import Foundation

public struct RankDTO: Decodable {
    public let resultCode: Int
    public let resultMsg: String
    public let resultData: [UserCountData]
}

extension RankDTO {
    func toDomain() -> RankResponse {
        .init(rankDatas: resultData)
    }
}
