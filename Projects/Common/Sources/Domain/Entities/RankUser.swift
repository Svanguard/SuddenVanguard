//
//  RankUser.swift
//  Common
//
//  Created by 최동호 on 9/6/24.
//  Copyright © 2024 Svanguard. All rights reserved.
//

import Foundation

public struct RankUser: Identifiable, Equatable {
    public let id: UUID
    public let username: String
    public let suddenNumber: Int
    public let count: Int
    public let userImage: String
    
    public init(username: String, suddenNumber: Int, count: Int, userImage: String) {
        self.id = UUID()
        self.username = username
        self.suddenNumber = suddenNumber
        self.count = count
        self.userImage = userImage
    }
}
