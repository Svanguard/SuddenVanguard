//
//  RankResponse.swift
//  Domain
//
//  Created by 최동호 on 8/29/24.
//  Copyright © 2024 Svanguard. All rights reserved.
//

import Foundation

public struct RankResponse {
    public let rankDatas: [UserCountData]
    
    public init(
        rankDatas: [UserCountData]
    ) {
        self.rankDatas = rankDatas
    }
}

public struct UserCountData: Decodable {
    public let userNexonSn: Int
    public let count: Int
}
