//
//  UserSearchService.swift
//  MainFeature
//
//  Created by 강치우 on 8/19/24.
//  Copyright © 2024 Svanguard. All rights reserved.
//

import Foundation

final class UserSearchService {
    func searchNickname(_ nickname: String) async throws -> [User] {
        let urlString = "https://barracks.sa.nexon.com/api/Search/GetSearchAll/\(nickname)/1"
        guard let url = URL(string: urlString) else {
            throw URLError(.badURL)
        }

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        for _ in 0..<3 { // 최대 3번 재시도
            do {
                let (data, response) = try await URLSession.shared.data(for: request)
                guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                    throw URLError(.badServerResponse)
                }
                let searchResponse = try JSONDecoder().decode(SearchResponse.self, from: data)
                return searchResponse.result.characterInfo
            } catch {
                if let urlError = error as? URLError, urlError.code == .networkConnectionLost {
                    continue // 연결이 끊어졌다면 재시도
                }
                throw error // 다른 오류는 그대로 던짐
            }
        }

        throw URLError(.cannotConnectToHost) // 3번 시도 후에도 실패하면 오류 발생
    }
}
