//
//  RankResponse.swift
//  Domain
//
//  Created by 최동호 on 8/29/24.
//  Copyright © 2024 Svanguard. All rights reserved.
//

import Common
import Foundation

public struct RankResponse {
    public let dailyDatas: [UserCountData]
    public let weeklyDatas: [UserCountData]
    public let monthlyDatas: [UserCountData]
    
    public init(
        dailyDatas: [UserCountData],
        weeklyDatas: [UserCountData],
        monthlyDatas: [UserCountData]
    ) {
        self.dailyDatas = dailyDatas
        self.weeklyDatas = weeklyDatas
        self.monthlyDatas = monthlyDatas
    }
}
