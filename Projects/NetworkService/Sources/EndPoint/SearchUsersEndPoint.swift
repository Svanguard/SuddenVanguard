//
//  SearchUsersEndPoint.swift
//  NetworkService
//
//  Created by 최동호 on 8/24/24.
//  Copyright © 2024 Svanguard. All rights reserved.
//

import Domain
import Foundation

public struct SearchUsersEndPoint: EndPoint {
    private let request: SearchUsersRequest
    
    public var scheme: Scheme {
        .https
    }
    
    public var host: String {
        Bundle.main.object(forInfoDictionaryKey: "NEXEN_URL") as? String ?? ""
    }
    
    public var port: String = ""
    
    public var path: String {
        "/api/Search/GetSearchAll/\(request.userName)"
    }
    
    public var query: [String : String] = [:]
    
    public var header: [String : String] {
        [
            "Content-Type": "application/json"
        ]
    }
    
    public var body: [String : Any] = [:]
    
    public var method: HTTPMethod = .post
    
    public init(
        request: SearchUsersRequest
    ) {
        self.request = request
    }
}
