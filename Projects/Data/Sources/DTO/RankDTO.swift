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
    public let resultData: RankData
}

public struct RankData: Decodable {
    let daily: [UserCountData]
    let weekly: [UserCountData]
    let monthly: [UserCountData]
}

extension RankDTO {
    func toDomain() -> RankResponse {
        .init(
            dailyDatas: resultData.daily,
            weeklyDatas: resultData.weekly,
            monthlyDatas: resultData.monthly
        )
    }
}
