//
//  SearchNickNameRequest.swift
//  ProjectDescriptionHelpers
//
//  Created by 최동호 on 8/5/24.
//

import Foundation

public struct SearchNickNameRequest {
    public let userName: String
    
    public init(
        userName: String
    ) {
        self.userName = userName
    }
}
