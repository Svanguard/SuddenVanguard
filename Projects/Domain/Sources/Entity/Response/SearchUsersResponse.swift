//
//  SearchUsersResponse.swift
//  Domain
//
//  Created by 최동호 on 8/24/24.
//  Copyright © 2024 Svanguard. All rights reserved.
//

import Foundation

public struct SearchUsersResponse: Decodable {
    public let suddenNumber: Int
    public let userName: String
    public let userImage: String
    
    public init(
        suddenNumber: Int,
        userName: String,
        userImage: String
    ) {
        self.suddenNumber = suddenNumber
        self.userName = userName
        self.userImage = userImage
    }
}
