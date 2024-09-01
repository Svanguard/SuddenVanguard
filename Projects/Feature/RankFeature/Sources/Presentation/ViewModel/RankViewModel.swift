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
    
    private var dailyResponse: RankResponse = .init(rankDatas: [])
    private var weeklyResponse: RankResponse = .init(rankDatas: [])
    private var monthlyResponse: RankResponse = .init(rankDatas: [])
    
    private var cancellables = Set<AnyCancellable>()
    private var currentDailyPage: Int = 0
    private var currentWeeklyPage: Int = 0
    private var currentMonthlyPage: Int = 0
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
        
        let filtered = text.isEmpty ? users : users.filter {
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
                guard dailyRankUsers.isEmpty else {
                    isLoading = false
                    return
                }
                checkIsRankResponse(period: period)

            case .weekly:
                guard weeklyRankUsers.isEmpty else {
                    isLoading = false
                    return
                }
                checkIsRankResponse(period: period)
 
            case .monthly:
                guard monthlyRankUsers.isEmpty else {
                    isLoading = false
                    return
                }
                checkIsRankResponse(period: period)
            }
        }
    }
    
    // MARK: 새로고침 로직
    func refreshData() {
//        loadData(for: .monthly) // 예시로 월간 데이터를 새로 로드
    }
    
    private func checkIsRankResponse(period: RankPeriod) {
        Task {
            switch period {
            case .daily:
                guard dailyResponse.rankDatas.isEmpty else { return }
                await getRankData(period: period)
            case .weekly:
                guard weeklyResponse.rankDatas.isEmpty else { return }
                await getRankData(period: period)
            case .monthly:
                guard monthlyResponse.rankDatas.isEmpty else { return }
                await getRankData(period: period)
            }
        }
    }
    
    func getRankData(period: RankPeriod) async {
        do {
            switch period {
            case .daily:
                dailyResponse = try await rankUseCase.getRankData(request: .init(requestType: .daily))
                await getDailyRankData()
            case .weekly:
                weeklyResponse = try await rankUseCase.getRankData(request: .init(requestType: .weekly))
                await getWeeklyRankData()
            case .monthly:
                monthlyResponse = try await rankUseCase.getRankData(request: .init(requestType: .monthly))
                await getMonthlyRankData()
            }
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func getDailyRankData() async {
        var tempUsers: [Int: RankUser] = [:]
        
        await withTaskGroup(of: (Int, RankUser?).self) { group in
            for (index, userData) in dailyResponse.rankDatas.prefix(20).enumerated() {
                group.addTask {
                    let rankUser = await self.fetchAndCreateRankUser(userData: userData)
                    return (index, rankUser)
                }
            }
            
            for await (index, rankUser) in group {
                if let rankUser = rankUser {
                    tempUsers[index] = rankUser
                }
            }
        }
        
        dailyRankUsers = (0..<tempUsers.count).compactMap { tempUsers[$0] }
        isLoading = false
        
    }
    
    func getWeeklyRankData() async {
        var tempUsers: [Int: RankUser] = [:]
        
        await withTaskGroup(of: (Int, RankUser?).self) { group in
            for (index, userData) in weeklyResponse.rankDatas.prefix(20).enumerated() {
                group.addTask {
                    let rankUser = await self.fetchAndCreateRankUser(userData: userData)
                    return (index, rankUser)
                }
            }
            
            for await (index, rankUser) in group {
                if let rankUser = rankUser {
                    tempUsers[index] = rankUser
                }
            }
        }
        weeklyRankUsers = (0..<tempUsers.count).compactMap { tempUsers[$0] }
        isLoading = false
    }
    
    func getMonthlyRankData() async {
        var tempUsers: [Int: RankUser] = [:]
        
        await withTaskGroup(of: (Int, RankUser?).self) { group in
            for (index, userData) in monthlyResponse.rankDatas.prefix(20).enumerated() {
                group.addTask {
                    let rankUser = await self.fetchAndCreateRankUser(userData: userData)
                    return (index, rankUser)
                }
            }
            
            for await (index, rankUser) in group {
                if let rankUser = rankUser {
                    tempUsers[index] = rankUser
                }
            }
        }
        monthlyRankUsers = (0..<tempUsers.count).compactMap { tempUsers[$0] }
        isLoading = false
    }
    
    private func fetchAndCreateRankUser(userData: UserCountData) async -> RankUser? {
        do {
            let profileResponse = try await rankUseCase.getProfileData(request: .init(suddenNumber: userData.userNexonSn))
            return RankUser(
                username: profileResponse.userName,
                suddenNumber: String(userData.userNexonSn),
                count: userData.count,
                userImage: profileResponse.userImage
            )
        } catch {
            print("\(userData.userNexonSn) 프로필 데이터 패치 실패: \(error.localizedDescription)")
        }
        return nil
    }
}

// MARK: - 무한스크롤
extension RankViewModel {
    
    // MARK: 무한 스크롤 로직
    func loadMoreData(for period: RankPeriod) async {
        guard !isLoadingMore else { return }
        isLoadingMore = true
        
        switch period {
        case .daily:
            currentDailyPage += 1
            let rankDatas = await loadMoreRankData(response: dailyResponse)
            dailyRankUsers.append(contentsOf: (0..<rankDatas.count).compactMap { rankDatas[$0] })

        case .weekly:
            currentWeeklyPage += 1
            let rankDatas = await loadMoreRankData(response: weeklyResponse)
            weeklyRankUsers.append(contentsOf: (0..<rankDatas.count).compactMap { rankDatas[$0] })

        case .monthly:
            currentMonthlyPage += 1
            let rankDatas = await loadMoreRankData(response: monthlyResponse)
            monthlyRankUsers.append(contentsOf: (0..<rankDatas.count).compactMap { rankDatas[$0] })
        }
        
        isLoadingMore = false
    }

    func loadMoreRankData(response: RankResponse) async -> [Int: RankUser] {

        
        var tempUsers: [Int: RankUser] = [:]
        
        await withTaskGroup(of: (Int, RankUser?).self) { group in
            for (index, userData) in response.rankDatas.suffix(pageSize).enumerated() {
                group.addTask {
                    let rankUser = await self.fetchAndCreateRankUser(userData: userData)
                    return (index, rankUser)
                }
            }
            
            for await (index, rankUser) in group {
                if let rankUser = rankUser {
                    tempUsers[index] = rankUser
                }
            }
        }
        
        return tempUsers
    }
}
