//
//  UserSearchViewModel.swift
//  MainFeature
//
//  Created by 강치우 on 8/19/24.
//  Copyright © 2024 Svanguard. All rights reserved.
//

import Core
import Common
import Domain
import Combine
import SwiftUI

final class UserSearchViewModel: ObservableObject {
    @Injected(SearchUseCase.self)
    public var searchUseCase: SearchUseCase
    
    @Published var searchQuery = ""
    @Published var users: [SearchUserData] = []
    @Published var userPunishDate: String = ""
    @Published var isLoading = false
    @Published var userFetchLoading = false
    @Published var searchHistory: [String] = []
    @Published var isSearchFieldFocused: Bool = true
    @Published var showAlert = false
    
    @Published var showResult = false
    @Published var resultType: PunishResultType = .clean

    private var cancellables = Set<AnyCancellable>()
    
    private let debounceDelay: TimeInterval = 0.5
    
    init() {
        loadSearchHistory()
        setupSearchDebounce()
    }

    func searchUsers() {
        guard !searchQuery.isEmpty else {
            users = []
            return
        }
        isLoading = true
        searchUseCase.searchUsers(request: .init(userName: searchQuery))
            .receive(on: DispatchQueue.main)
            .sink { [weak self] completion in
                self?.isLoading = false
                if case .failure(let error) = completion {
                    print("검색 실패 에러: \(error)")
                }
            } receiveValue: { [weak self] response in
                self?.users = response.map { userResponse in
                    SearchUserData(
                        suddenNumber: userResponse.suddenNumber,
                        userName: userResponse.userName,
                        userImage: userResponse.userImage
                    )
                }
            }
            .store(in: &cancellables)
    }
    
    func searchNumber(userSuddenNumber: Int) {
        guard userSuddenNumber != 0 else {
            return
        }
        
        userFetchLoading = true
        
        searchUseCase.searchNumber(request: .init(suddenNumber: userSuddenNumber))
            .receive(on: DispatchQueue.main)
            .sink { [weak self] completion in
                guard let self = self else { return }
                self.userFetchLoading = false
                if case .failure(let error) = completion {
                    print("번호로 서버에서 데이터 가져오기 에러: \(error)")
                }
            } receiveValue: { [weak self] response in
                guard let self = self else { return }

                print(response)
                switch response.punishType {
                case "restriction":
                    self.resultType = .restriction
                    self.userPunishDate = response.punishDate
                case "protection":
                    self.resultType = .protection
                    self.userPunishDate = response.punishDate
                default:
                    switch response.registerFg {
                    case true:
                        self.resultType = .success
                    case false:
                        self.resultType = .clean
                    }
                }
               
                self.userFetchLoading = false
            }
            .store(in: &cancellables)
    }

    // 검색 기록에서 선택한 항목을 검색
    func performSearch(for query: String) {
        searchQuery = query
        searchUsers()
    }

    // 검색 기록에 유저 추가
    func addUserToSearchHistory(_ user: SearchUserData) {
        let query = user.userName
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

    private func setupSearchDebounce() {
        $searchQuery
            .debounce(for: .seconds(debounceDelay), scheduler: DispatchQueue.main)
            .removeDuplicates()
            .sink { [weak self] query in
                guard let self = self else { return }
                self.searchUsers()
            }
            .store(in: &cancellables)
    }
}
