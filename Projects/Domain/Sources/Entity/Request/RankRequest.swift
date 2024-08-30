//
//  RankRequest.swift
//  Domain
//
//  Created by 최동호 on 8/30/24.
//  Copyright © 2024 Svanguard. All rights reserved.
//

import Foundation

public enum RankRequestType: String {
    case daily = "daily"
    case weekly = "weekly"
    case monthly = "monthly"
}

public struct RankRequest {
    public let requestType: RankRequestType
    
    public init(requestType: RankRequestType) {
        self.requestType = requestType
    }
}
