//
//  UserSearchService.swift
//  MainFeature
//
//  Created by 강치우 on 8/19/24.
//  Copyright © 2024 Svanguard. All rights reserved.
//

import Combine
import Foundation

class UserSearchService {
    func searchNickname(_ nickname: String) -> AnyPublisher<[User], Error> {
        let urlString = "https://barracks.sa.nexon.com/api/Search/GetSearchAll/\(nickname)/1"
        guard let url = URL(string: urlString) else {
            return Fail(error: URLError(.badURL))
                .eraseToAnyPublisher()
        }

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        return URLSession.shared.dataTaskPublisher(for: request)
            .tryMap { data, response in
                guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                    throw URLError(.badServerResponse)
                }
                return data
            }
            .decode(type: SearchResponse.self, decoder: JSONDecoder())
            .map { $0.result.characterInfo }
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
}
