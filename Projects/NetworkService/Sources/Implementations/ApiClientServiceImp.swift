//
//  ApiClientServiceImp.swift
//  Data
//
//  Created by 최동호 on 8/5/24.
//  Copyright © 2024 Svanguard. All rights reserved.
//

import Foundation

public struct ApiClientServiceImp: ApiClientService {
    let session: URLSession
    
    public init(session: URLSession = URLSession.shared) {
        self.session = session
    }
    
    public func request<T: Decodable>(request: URLRequest, type: T.Type) async throws -> T where T : Decodable {
        let (data, response) = try await session.data(for: request)
        return try validateResponse(data: data, response: response)
    }
    
    private func validateResponse<T: Decodable>(
        data: Data,
        response: URLResponse
    ) throws -> T {
        guard let httpResponse = response as? HTTPURLResponse else {
            throw ApiError.unknownError
        }
        
        switch httpResponse.statusCode {
        case HttpResponseStatus.ok:
            return try decodeModel(data: data)
        case HttpResponseStatus.clientError:
            throw ApiError.clientError
        case HttpResponseStatus.serverError:
            throw ApiError.serverError
        default:
            throw ApiError.unknownError
        }
    }
    
    private func decodeModel<T: Decodable>(data: Data) throws -> T {
        let decoder = JSONDecoder()
        let model = try? decoder.decode(T.self, from: data)
        guard let model = model else { throw ApiError.errorDecoding }
        return model
    }
}
