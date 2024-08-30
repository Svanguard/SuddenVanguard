//
//  ApiClientService.swift
//  Data
//
//  Created by 최동호 on 8/5/24.
//  Copyright © 2024 Svanguard. All rights reserved.
//

import Foundation

public protocol ApiClientService {
    func request<T: Decodable>(request: URLRequest, type: T.Type) async throws -> T
}
