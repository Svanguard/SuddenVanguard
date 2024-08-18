//
//  SearchRepositoryImp.swift
//  Data
//
//  Created by 최동호 on 8/18/24.
//  Copyright © 2024 Svanguard. All rights reserved.
//

import Domain
import NetworkService
import Foundation

public final class SearchRepositoryImp: SearchRepository {
    let apiClientService: ApiClientService
    
    public init(apiClientService: ApiClientService) {
        self.apiClientService = apiClientService
    }
    
    public func searchNickName(
        request: SearchNickNameRequest,
        completion: @escaping (Result<SearchNickNameResponse, Error>) -> Void) {
            Task {
                do {
                    let endPoint = SearchEndPoint(request: request)
                    guard let urlRequest = endPoint.toURLRequest else {
                        throw ApiError.errorInUrl
                    }
                    let response: SearchNickNameResponse = try await apiClientService.request(request: urlRequest, type: SearchNickNameDTO.self).toDomain()
                    completion(.success(response))
                } catch {
                    completion(.failure(error))
                }
            }
    }
    
    
}
