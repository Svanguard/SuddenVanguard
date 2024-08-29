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
    let suddenNumber: String
    let count: Int
    let userImage: String
    
    init(username: String, suddenNumber: String, count: Int, userImage: String) {
        self.id = UUID()
        self.username = username
        self.suddenNumber = suddenNumber
        self.count = count
        self.userImage = userImage
    }
    
    // 더미 데이터
    static var dummyData: [RankUser] {
        return [
            RankUser(username: "이창준", suddenNumber: "1828886846", count: 23, userImage: ""),
            RankUser(username: "강치우", suddenNumber: "554246255", count: 4122, userImage: ""),
            RankUser(username: "김희성", suddenNumber: "839379262", count: 2131, userImage: ""),
            RankUser(username: "최동호", suddenNumber: "2030679619", count: 4342, userImage: ""),
            RankUser(username: "노주영", suddenNumber: "1812070041", count: 324, userImage: ""),
            RankUser(username: "김명현", suddenNumber: "1359578496", count: 232, userImage: ""),
            RankUser(username: "황민채", suddenNumber: "553913652", count: 125, userImage: ""),
            RankUser(username: "이민영", suddenNumber: "403320873", count: 4566, userImage: ""),
            RankUser(username: "황성진", suddenNumber: "537014909", count: 9654, userImage: ""),
            // MARK: 무한스크롤 테스트를 위한 더미 데이터
            RankUser(username: "추가유저1", suddenNumber: "1122334455", count: 22, userImage: ""),
            RankUser(username: "추가유저2", suddenNumber: "2233445566", count: 21, userImage: ""),
            RankUser(username: "추가유저3", suddenNumber: "1122334455", count: 20, userImage: ""),
            RankUser(username: "추가유저4", suddenNumber: "2233445566", count: 19, userImage: ""),
            RankUser(username: "추가유저5", suddenNumber: "1122334455", count: 18, userImage: ""),
            RankUser(username: "추가유저6", suddenNumber: "2233445566", count: 17, userImage: ""),
            RankUser(username: "추가유저7", suddenNumber: "1122334455", count: 16, userImage: ""),
            RankUser(username: "추가유저8", suddenNumber: "2233445566", count: 15, userImage: ""),
            RankUser(username: "추가유저9", suddenNumber: "1122334455", count: 14, userImage: ""),
            RankUser(username: "추가유저10", suddenNumber: "2233445566", count: 13, userImage: ""),
            RankUser(username: "추가유저11", suddenNumber: "1122334455", count: 12, userImage: ""),
            RankUser(username: "추가유저12", suddenNumber: "2233445566", count: 11, userImage: ""),
            RankUser(username: "추가유저13", suddenNumber: "1122334455", count: 10, userImage: ""),
            RankUser(username: "추가유저14", suddenNumber: "2233445566", count: 9, userImage: ""),
            RankUser(username: "추가유저15", suddenNumber: "1122334455", count: 8, userImage: ""),
            RankUser(username: "추가유저16", suddenNumber: "2233445566", count: 7, userImage: "")
        ]
    }
}
