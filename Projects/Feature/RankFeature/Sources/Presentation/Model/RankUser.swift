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
    let suddenNumber: Int
    let count: Int
    let userImage: String
    
    init(username: String, suddenNumber: Int, count: Int, userImage: String) {
        self.id = UUID()
        self.username = username
        self.suddenNumber = suddenNumber
        self.count = count
        self.userImage = userImage
    }
}
