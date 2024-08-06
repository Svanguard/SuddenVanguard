//
//  RankUser.swift
//  RankFeature
//
//  Created by 강치우 on 8/6/24.
//  Copyright © 2024 Svanguard. All rights reserved.
//

import Foundation

struct RankUser: Identifiable {
    let id: UUID
    let username: String
    let userID: String
    var frequency: Int
    
    init(username: String, userID: String, frequency: Int) {
        self.id = UUID()
        self.username = username
        self.userID = userID
        self.frequency = frequency
    }
    
    // 더미 데이터
    static var dummyData: [RankUser] {
        return [
            RankUser(username: "이창준", userID: "1828886846", frequency: 23),
            RankUser(username: "강치우", userID: "554246255", frequency: 4122),
            RankUser(username: "김희성", userID: "839379262", frequency: 2131),
            RankUser(username: "최동호", userID: "2030679619", frequency: 4342),
            RankUser(username: "노주영", userID: "1812070041", frequency: 324),
            RankUser(username: "김명현", userID: "1359578496", frequency: 232),
            RankUser(username: "황민채", userID: "553913652", frequency: 125),
            RankUser(username: "이민영", userID: "403320873", frequency: 4566),
            RankUser(username: "황성진", userID: "537014909", frequency: 9654),
        ]
    }
}
