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
    @Published var searchHistory: [String] = []

    private var cancellables = Set<AnyCancellable>()
    private let searchService = UserSearchService()

    init() {
        setupSearchListener()
        loadSearchHistory()
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
                    .catch { _ in Just([]) }
                    .eraseToAnyPublisher()
            }
            .sink { [weak self] users in
                self?.isLoading = false
                self?.users = users
                self?.updateSearchHistory()
            }
            .store(in: &cancellables)
    }
    
    private func updateSearchHistory() {
        guard !searchQuery.isEmpty else { return }
        
        // 기존에 같은 검색어가 있으면 제거
        if let index = searchHistory.firstIndex(of: searchQuery) {
            searchHistory.remove(at: index)
        }
        
        // 검색어를 맨 앞에 추가
        searchHistory.insert(searchQuery, at: 0)
        
        // 검색 기록 저장
        saveSearchHistory()
    }
    
    private func loadSearchHistory() {
        // UserDefaults에서 검색 기록 불러오기
        searchHistory = UserDefaults.standard.stringArray(forKey: "searchHistory") ?? []
    }
    
    private func saveSearchHistory() {
        // UserDefaults에 검색 기록 저장하기
        UserDefaults.standard.set(searchHistory, forKey: "searchHistory")
    }

    func deleteSearchHistory(at offsets: IndexSet) {
        searchHistory.remove(atOffsets: offsets)
        saveSearchHistory()
    }
}
