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
    @Published var searchQuery = "" {
        didSet {
            // searchQuery가 변경될 때 디바운싱 처리
            debounceSearchQuery()
        }
    }
    @Published var users: [User] = []
    @Published var isLoading = false
    @Published var searchHistory: [String] = []
    @Published var isSearchFieldFocused: Bool = true
    @Published var showAlert = false
    
    @Published var showResult = false
    @Published var resultType: ResultType = .clean

    private var cancellables = Set<AnyCancellable>()
    private let searchService = UserSearchService()
    
    private var searchWorkItem: DispatchWorkItem?
    // 디바운스 딜레이 시간
    private let debounceDelay: TimeInterval = 0.3

    init() {
        loadSearchHistory()
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

    // 검색 기록 관리 메서드
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
    
    // 디바운싱을 위한 메서드
    private func debounceSearchQuery() {
        searchWorkItem?.cancel()
        
        let workItem = DispatchWorkItem { [weak self] in
            guard let self = self else { return }
            Task {
                await self.searchUsers()
            }
        }
        
        // 0.3초 후에 검색하도록 설정
        searchWorkItem = workItem
        DispatchQueue.main.asyncAfter(deadline: .now() + debounceDelay, execute: workItem)
    }
}
