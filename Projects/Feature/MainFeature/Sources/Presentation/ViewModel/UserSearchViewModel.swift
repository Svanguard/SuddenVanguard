//
//  UserSearchViewModel.swift
//  MainFeature
//
//  Created by 강치우 on 8/19/24.
//  Copyright © 2024 Svanguard. All rights reserved.
//

import Combine
import SwiftUI

@MainActor
final class UserSearchViewModel: ObservableObject {
    @Published var searchQuery = ""
    @Published var users: [User] = []
    @Published var isLoading = false
    @Published var searchHistory: [String] = []
    @Published var isSearchFieldFocused: Bool = true
    @Published var showAlert = false
    
    @Published var showResult = false
    @Published var resultType: ResultType = .clean

    private var cancellables = Set<AnyCancellable>()
    private let searchService = UserSearchService()
    
    private let debounceDelay: TimeInterval = 0.5
    
    init() {
        loadSearchHistory()
        setupSearchDebounce()
    }

    func searchUsers() async {
        guard !searchQuery.isEmpty else {
            users = []
            return
        }
        isLoading = true
        do {
            users = try await searchService.searchNickname(searchQuery)
        } catch {
            users = []
        }
        isLoading = false
    }

    // 검색 기록에서 선택한 항목을 검색
    func performSearch(for query: String) {
        searchQuery = query
        Task {
            await searchUsers()
        }
    }

    // 검색 기록에 유저 추가
    func addUserToSearchHistory(_ user: User) {
        let query = user.user_nick
        updateSearchHistory(with: query)
    }

    // 검색 기록 관련 함수
    private func updateSearchHistory(with query: String) {
        guard !query.isEmpty else { return }

        if let index = searchHistory.firstIndex(of: query) {
            searchHistory.remove(at: index)
        }

        searchHistory.insert(query, at: 0)
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

    /// 디바운싱(Debouncing)
    /// 디바운싱 적용한 이유: searchable 같은 자음 모음마다 리스트가 업데이트 되는 검색기능이 있는 경우, 디바운싱 처리를 해서 딜레이를 걸어줘야 리스트가 정상적으로 업데이트됨.
    /// 딜레이 안걸어주면 리스트가 업데이트 과부하 걸려서 빈 셀을 반환한다는 오류뱉음
    private func setupSearchDebounce() {
        $searchQuery
            .debounce(for: .seconds(debounceDelay), scheduler: DispatchQueue.main)
            .removeDuplicates()
            .sink { [weak self] query in
                guard let self = self else { return }
                Task {
                    await self.searchUsers()
                }
            }
            .store(in: &cancellables)
    }
}
