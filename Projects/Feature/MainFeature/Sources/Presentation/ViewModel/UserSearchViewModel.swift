//
//  UserSearchViewModel.swift
//  MainFeature
//
//  Created by 강치우 on 8/19/24.
//  Copyright © 2024 Svanguard. All rights reserved.
//

import Foundation
import Combine

class UserSearchViewModel: ObservableObject {
    @Published var searchQuery = ""
    @Published var users: [User] = []
    @Published var isLoading = false

    private var cancellables = Set<AnyCancellable>()
    private let searchService = UserSearchService()

    init() {
        setupSearchListener()
    }

    private func setupSearchListener() {
        $searchQuery
            .debounce(for: .milliseconds(500), scheduler: RunLoop.main)
            .removeDuplicates()
            .flatMap { query -> AnyPublisher<[User], Never> in
                guard !query.isEmpty else {
                    return Just([]).eraseToAnyPublisher()
                }
                self.isLoading = true
                return self.searchService.searchNickname(query)
                    .catch { error in
                        print("Search error: \(error.localizedDescription)")
                        return Just([User]()).eraseToAnyPublisher()
                    }
                    .eraseToAnyPublisher()
            }
            .sink { [weak self] users in
                self?.isLoading = false
                self?.users = users
            }
            .store(in: &cancellables)
    }
}
