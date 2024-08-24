//
//  SearchNumberRepositoryImp.swift
//  Data
//
//  Created by 최동호 on 8/18/24.
//  Copyright © 2024 Svanguard. All rights reserved.
//

import Domain
import NetworkService
import Foundation

public final class SearchNumberRepositoryImp: SearchNumberRepository {
    let apiClientService: ApiClientService
    
    public init(apiClientService: ApiClientService) {
        self.apiClientService = apiClientService
    }
    
    public func searchNumber(
        request: SearchNumberRequest,
        completion: @escaping (Result<SearchNumberResponse, Error>) -> Void) {
            Task {
                do {
                    let endPoint = SearchNumberEndPoint(request: request)
                    guard let urlRequest = endPoint.toURLRequest else {
                        throw ApiError.errorInUrl
                    }
                    let response: SearchNumberResponse = try await apiClientService.request(request: urlRequest, type: SearchNumberDTO.self).toDomain()
                    completion(.success(response))
                } catch {
                    completion(.failure(error))
                }
            }
    }
    
    
}
