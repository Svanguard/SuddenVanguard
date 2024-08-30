//
//  RankViewModel.swift
//  RankFeature
//
//  Created by 강치우 on 8/6/24.
//  Copyright © 2024 Svanguard. All rights reserved.
//

import Core
import Common
import Domain
import Combine
import Foundation

final class RankViewModel: ObservableObject {
    @Injected(RankUseCase.self)
    public var rankUseCase: RankUseCase
    
    @Published var text: String = ""
    @Published var users: [RankUser] = []
    @Published var isLoading: Bool = true
    @Published var isLoadingMore: Bool = false
    @Published var showActionSheet = false
    @Published var selectedPeriod: RankPeriod = .monthly
    
    private var cancellables = Set<AnyCancellable>()
    private var currentPage: Int = 1
    private let pageSize: Int = 10
    
    init() {
        loadData(for: .monthly)
    }
    
    // MARK: 필터링 로직
    var filteredUsers: [RankUser] {
        let sortedUsers = users.sorted { $0.count > $1.count }
        let filtered = text.isEmpty ? sortedUsers : sortedUsers.filter { $0.username.contains(text) || $0.suddenNumber.contains(text) }
        
        return filtered
    }
    
    var isSearching: Bool {
        return !text.isEmpty
    }
    
    // MARK: 선택된 기간에 따른 데이터 로드
    func loadData(for period: RankPeriod) {
        isLoading = true
        
        switch period {
        case .daily:
            getDailyRankData()
        case .weekly:
            getWeeklyRankData()
        case .monthly:
            getMonthlyRankData()
        }
    }
    
    // MARK: 새로고침 로직
    func refreshData() {
        loadData(for: .monthly) // 예시로 월간 데이터를 새로 로드
    }
    
    /// MARK: - 일,주,월간별로 더미데이터 넣어둠
    /// 밑에 함수 만들어둔거 확인했음 로직 완성하고 바꾸면 될듯
    func getDailyRankData() {
        // 일간 데이터 로드 로직
        users = RankUser.dummyData.shuffled().prefix(pageSize).map { $0 }
        isLoading = false
    }
    
    func getWeeklyRankData() {
        // 주간 데이터 로드 로직
        users = RankUser.dummyData.shuffled().prefix(pageSize).map { $0 }
        isLoading = false
    }
    
    func getMonthlyRankData() {
        // 월간 데이터 로드 로직
        users = RankUser.dummyData.shuffled().prefix(pageSize).map { $0 }
        isLoading = false
    }
    
    // MARK: 무한 스크롤 로직
    func loadMoreData() {
        guard !isLoadingMore else { return }
        isLoadingMore = true
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            let startIndex = self.users.count
            let endIndex = startIndex + self.pageSize
            let moreUsers = RankUser.dummyData[startIndex..<min(endIndex, RankUser.dummyData.count)]
            self.users.append(contentsOf: moreUsers)
            self.isLoadingMore = false
        }
    }
    
    func getDailyRankData() async {
        do {
            let response = try await rankUseCase.getRankData(request: .init(requestType: .daily))
            print(response)
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func getWeeklyRankData() async {
        do {
            let response = try await rankUseCase.getRankData(request: .init(requestType: .weekly))
            print(response)
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func getMonthlyRankData() async {
        do {
            let response = try await rankUseCase.getRankData(request: .init(requestType: .monthly))
            print(response)
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func getProfileData(suddenNumber: Int) async {
        do {
            let response = try await rankUseCase.getProfileData(request: .init(suddenNumber: suddenNumber))
            print(response)
            
        } catch {
            print(error.localizedDescription)
        }
    }
}
