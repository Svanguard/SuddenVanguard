//
//  HTTPMethod.swift
//  ProjectDescriptionHelpers
//
//  Created by 최동호 on 8/5/24.
//

import Foundation

public enum HTTPMethod {
    case get, put, post, patch, delete
    
    var toString: String {
        switch self {
        case .get:
            return "GET"
        case .put:
            return "PUT"
        case .post:
            return "POST"
        case .patch:
            return "PATCH"
        case .delete:
            return "DELETE"
        }
    }
}
