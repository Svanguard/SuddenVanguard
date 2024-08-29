//
//  RankEndPoint.swift
//  NetworkService
//
//  Created by 최동호 on 8/29/24.
//  Copyright © 2024 Svanguard. All rights reserved.
//

import Domain
import Foundation

public struct RankEndPoint: EndPoint {
    public var scheme: Scheme {
        .http
    }
    
    public var host: String {
        Bundle.main.object(forInfoDictionaryKey: "HOST_VALUE") as? String ?? ""
    }
    
    public var port: String {
        Bundle.main.object(forInfoDictionaryKey: "PORT_NUMBER") as? String ?? ""
    }
    
    public var path: String {
        "/api/v1/users/rankings"
    }
    
    public var query: [String : String] = [:]
    
    public var header: [String : String] = [:]
    
    public var body: [String : Any] = [:]
    
    public var method: HTTPMethod = .get
    
    public init() { }
}
