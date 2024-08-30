//
//  SearchNickNameResponse.swift
//  Domain
//
//  Created by 최동호 on 8/18/24.
//  Copyright © 2024 Svanguard. All rights reserved.
//

import Foundation

public struct SearchNumberResponse: Decodable {
    public let suddenNumber: Int
    public let userName: String
    public let punishType: String
    public let punishDate: String
    public let registerFg: Bool
    
    public init(
        suddenNumber: Int,
        userName: String,
        punishType: String,
        punishDate: String,
        registerFg: Bool
    ) {
        self.suddenNumber = suddenNumber
        self.userName = userName
        self.punishType = punishType
        self.punishDate = punishDate
        self.registerFg = registerFg
    }
}

