//
//  SearchEndPoint.swift
//  NetworkService
//
//  Created by 최동호 on 8/18/24.
//  Copyright © 2024 Svanguard. All rights reserved.
//

import Domain
import Foundation

public struct SearchEndPoint: EndPoint {
    private let request: SearchNickNameRequest
    
    public var path: String = "/api/v1/users/search"
    
    public var query: [String : String] {
        ["nickname": request.userName]
    }
    
    public var header: [String : String] = ["": ""]
    
    public var body: [String : Any] = [:]
    
    public var method: HTTPMethod = .get
    
    public init(
        request: SearchNickNameRequest
    ) {
        self.request = request
    }
}
