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

@MainActor
final class RankViewModel: ObservableObject {
    @Injected(RankUseCase.self)
    public var rankUseCase: RankUseCase
    
    @Published var text: String = ""
    @Published var dailyRankUsers: [RankUser] = []
    @Published var weeklyRankUsers: [RankUser] = []
    @Published var monthlyRankUsers: [RankUser] = []
    @Published var isLoading: Bool = true
    @Published var isLoadingMore: Bool = false
    @Published var showActionSheet = false
    @Published var selectedPeriod: RankPeriod = .monthly
    
    private var cancellables = Set<AnyCancellable>()
    private var currentPage: Int = 1
    private let pageSize: Int = 10
    
    init() {
        Task {
            await loadData(for: .monthly)
        }
    }
    
    // MARK: 필터링 로직
    var filteredUsers: [RankUser] {
        let users: [RankUser]
        
        switch selectedPeriod {
        case .daily:
            users = dailyRankUsers
        case .weekly:
            users = weeklyRankUsers
        case .monthly:
            users = monthlyRankUsers
        }
        
        let sortedUsers = users.sorted { $0.count > $1.count }
        
        let filtered = text.isEmpty ? sortedUsers : sortedUsers.filter {
            $0.username.contains(text) || $0.suddenNumber.contains(text)
        }
        
        return filtered
    }
    var isSearching: Bool {
        return !text.isEmpty
    }
    
    // MARK: 선택된 기간에 따른 데이터 로드
    func loadData(for period: RankPeriod) async {
        isLoading = true
        
        Task {
            switch period {
            case .daily:
                await getDailyRankData()
            case .weekly:
                await getWeeklyRankData()
            case .monthly:
                await getMonthlyRankData()
            }
        }
    }
    
    // MARK: 새로고침 로직
    func refreshData() {
//        loadData(for: .monthly) // 예시로 월간 데이터를 새로 로드
    }
    
    // MARK: 무한 스크롤 로직
    func loadMoreData() {
//        guard !isLoadingMore else { return }
//        isLoadingMore = true
//        
//        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
//            let startIndex = self.users.count
//            let endIndex = startIndex + self.pageSize
//            let moreUsers = RankUser.dummyData[startIndex..<min(endIndex, RankUser.dummyData.count)]
//            self.users.append(contentsOf: moreUsers)
//            self.isLoadingMore = false
//        }
    }
    
    func getDailyRankData() async {
        do {
            let response = try await rankUseCase.getRankData(request: .init(requestType: .daily))
            dailyRankUsers = []
            for userData in response.rankDatas {
                await fetchAndAppendProfileData(userData: userData, period: .daily)
            }
            
            isLoading = false
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func getWeeklyRankData() async {
        do {
            let response = try await rankUseCase.getRankData(request: .init(requestType: .weekly))
            weeklyRankUsers = []
            for userData in response.rankDatas {
                await fetchAndAppendProfileData(userData: userData, period: .weekly)
            }
            
            isLoading = false
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func getMonthlyRankData() async {
        do {
            let response = try await rankUseCase.getRankData(request: .init(requestType: .monthly))
            monthlyRankUsers = []
            for userData in response.rankDatas {
                await fetchAndAppendProfileData(userData: userData, period: .monthly)
            }
            
            isLoading = false
            print(monthlyRankUsers)
        } catch {
            print(error.localizedDescription)
        }
    }
    
    private func fetchAndAppendProfileData(userData: UserCountData, period: RankPeriod) async {
        do {
            let profileResponse = try await rankUseCase.getProfileData(request: .init(suddenNumber: userData.userNexonSn))
            let newRankUser = RankUser(
                username: profileResponse.userName,
                suddenNumber: String(userData.userNexonSn),
                count: userData.count,
                userImage: profileResponse.userImage
            )
            
            DispatchQueue.main.async {
                switch period {
                case .daily:
                    self.dailyRankUsers.append(newRankUser)
                case .weekly:
                    self.weeklyRankUsers.append(newRankUser)
                case .monthly:
                    self.monthlyRankUsers.append(newRankUser)
                }
            }
            
        } catch {
            print("\(userData.userNexonSn) 프로필 데이터 패치 실패: \(error.localizedDescription)")
        }
    }
}
