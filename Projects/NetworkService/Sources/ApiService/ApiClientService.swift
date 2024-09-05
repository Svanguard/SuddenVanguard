//
//  ApiClientService.swift
//  Data
//
//  Created by 최동호 on 8/5/24.
//  Copyright © 2024 Svanguard. All rights reserved.
//

import Combine
import Foundation

public protocol ApiClientService {
    func request<T: Decodable>(request: URLRequest, type: T.Type) async throws -> T
    func requestPublisher<T: Decodable>(request: URLRequest, type: T.Type) -> AnyPublisher<T, Error>

}
