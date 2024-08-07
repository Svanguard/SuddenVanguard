//
//  RankUser.swift
//  RankFeature
//
//  Created by 강치우 on 8/6/24.
//  Copyright © 2024 Svanguard. All rights reserved.
//

import Foundation

struct RankUser: Identifiable, Equatable {
    let id: UUID
    let username: String
    let userID: String
    var frequency: Int
    var rank: Int?
    
    init(username: String, userID: String, frequency: Int, rank: Int? = nil) {
        self.id = UUID()
        self.username = username
        self.userID = userID
        self.frequency = frequency
        self.rank = rank
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
            // MARK: 무한스크롤 테스트를 위한 더미 데이터
            RankUser(username: "추가유저1", userID: "1122334455", frequency: 22),
            RankUser(username: "추가유저2", userID: "2233445566", frequency: 21),
            RankUser(username: "추가유저3", userID: "1122334455", frequency: 20),
            RankUser(username: "추가유저4", userID: "2233445566", frequency: 19),
            RankUser(username: "추가유저5", userID: "1122334455", frequency: 18),
            RankUser(username: "추가유저6", userID: "2233445566", frequency: 17),
            RankUser(username: "추가유저7", userID: "1122334455", frequency: 16),
            RankUser(username: "추가유저8", userID: "2233445566", frequency: 15),
            RankUser(username: "추가유저9", userID: "1122334455", frequency: 14),
            RankUser(username: "추가유저10", userID: "2233445566", frequency: 13),
            RankUser(username: "추가유저11", userID: "1122334455", frequency: 12),
            RankUser(username: "추가유저12", userID: "2233445566", frequency: 11),
            RankUser(username: "추가유저13", userID: "1122334455", frequency: 10),
            RankUser(username: "추가유저14", userID: "2233445566", frequency: 9),
            RankUser(username: "추가유저15", userID: "1122334455", frequency: 8),
            RankUser(username: "추가유저16", userID: "2233445566", frequency: 7)
        ]
    }
}
