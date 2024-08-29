//
//  ProfileEndPoint.swift
//  NetworkService
//
//  Created by 최동호 on 8/29/24.
//  Copyright © 2024 Svanguard. All rights reserved.
//

import Domain
import Foundation

public struct ProfileEndPoint: EndPoint {

    private let request: GetProfileRequest
    
    public var scheme: Scheme {
        .https
    }
    
    public var host: String {
        Bundle.main.object(forInfoDictionaryKey: "NEXEN_URL") as? String ?? ""
    }
    
    public var port: String = ""
    
    public var path: String {
        "/api/Profile/GetProfileMain/\(request.suddenNumber)"
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
        request: GetProfileRequest
    ) {
        self.request = request
    }
}
