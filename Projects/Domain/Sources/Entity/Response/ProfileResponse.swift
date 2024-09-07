//
//  ProfileResponse.swift
//  Domain
//
//  Created by 최동호 on 8/29/24.
//  Copyright © 2024 Svanguard. All rights reserved.
//

import Foundation

public struct ProfileResponse {
    public let userName: String
    public let userImage: String
    
    public init(
        userName: String,
        userImage: String
    ) {
        self.userName = userName
        self.userImage = userImage
    }
}
