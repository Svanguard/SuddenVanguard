//
//  UserSearchViewModel.swift
//  MainFeature
//
//  Created by 강치우 on 8/19/24.
//  Copyright © 2024 Svanguard. All rights reserved.
//

import Combine
import Foundation

class UserSearchViewModel: ObservableObject {
    @Published var searchQuery = ""
    @Published var users: [User] = []
    @Published var isLoading = false
    @Published var searchHistory: [String] = []
    @Published var isSearchFieldFocused: Bool = true
    @Published var showAlert = false

    private var cancellables = Set<AnyCancellable>()
    private let searchService = UserSearchService()
    
    private let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "MM. dd."
        return formatter
    }()

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
                self.updateSearchHistory(with: query) // 사용자가 입력한 검색어를 기록
                return self.searchService.searchNickname(query)
                    .catch { _ in Just([]) }
                    .eraseToAnyPublisher()
            }
            .sink { [weak self] users in
                self?.isLoading = false
                self?.users = users
            }
            .store(in: &cancellables)
    }

    private func updateSearchHistory(with query: String) {
        guard !query.isEmpty else { return }

        // 동일한 검색어가 이미 있으면 제거
        if let index = searchHistory.firstIndex(of: query) {
            searchHistory.remove(at: index)
        }

        // 검색어를 맨 앞에 추가
        searchHistory.insert(query, at: 0)

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

    func clearSearchHistory() {
        searchHistory.removeAll()
        saveSearchHistory()
    }

    func performSearch(for query: String) {
        searchQuery = query
    }
    
    func formattedDate(for date: Date) -> String {
        return dateFormatter.string(from: date)
    }
}
