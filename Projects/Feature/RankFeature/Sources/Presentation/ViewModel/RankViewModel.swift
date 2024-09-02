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
    
    private var remainDailyPage: Bool = true
    private var remainWeeklyPage: Bool = true
    private var remainMonthlyPage: Bool = true
    private let pageSize: Int = 10
    
    init() {
        Task {
            await loadData()
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
    func loadData() async {
        isLoading = true
        
        Task {
            switch selectedPeriod {
            case .daily:
                guard dailyRankUsers.isEmpty else {
                    isLoading = false
                    return
                }
                checkIsRankResponse()

            case .weekly:
                guard weeklyRankUsers.isEmpty else {
                    isLoading = false
                    return
                }
                checkIsRankResponse()
 
            case .monthly:
                guard monthlyRankUsers.isEmpty else {
                    isLoading = false
                    return
                }
                checkIsRankResponse()
            }
        }
    }
    
    // MARK: 새로고침 로직
    func refreshData() async {
        switch selectedPeriod {
        case .daily:
            dailyResponse = .init(rankDatas: [])
            await getRankData()
        case .weekly:
            weeklyResponse = .init(rankDatas: [])
            await getRankData()
        case .monthly:
            monthlyResponse = .init(rankDatas: [])
            await getRankData()
        }
    }
    
    private func checkIsRankResponse() {
        Task {
            switch selectedPeriod {
            case .daily:
                guard dailyResponse.rankDatas.isEmpty else { return }
                await getRankData()
            case .weekly:
                guard weeklyResponse.rankDatas.isEmpty else { return }
                await getRankData()
            case .monthly:
                guard monthlyResponse.rankDatas.isEmpty else { return }
                await getRankData()
            }
        }
    }
    
    func getRankData() async {
        do {
            switch selectedPeriod {
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
        
        currentDailyPage += 2
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
        
        currentWeeklyPage += 2
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
        
        currentMonthlyPage += 2
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
    func loadMoreData() async {
        guard !isLoadingMore else { return }
        isLoadingMore = true
        var rankDatas: [Int: RankUser] = [:]
        
        switch selectedPeriod {
        case .daily:
            currentDailyPage += 1
            rankDatas = await loadMoreRankData(
                response: dailyResponse,
                period: .daily,
                page: currentDailyPage
            )
            dailyRankUsers.append(contentsOf: rankDatas.values)
            
        case .weekly:
            currentWeeklyPage += 1
            print("현재 주별 페이지: \(currentWeeklyPage)")
            rankDatas = await loadMoreRankData(
                response: weeklyResponse,
                period: .weekly,
                page: currentWeeklyPage
            )
            weeklyRankUsers.append(contentsOf: rankDatas.values)
            print("주별 데이터 추가됨: \(rankDatas.count)개")
            
        case .monthly:
            currentMonthlyPage += 1
            rankDatas = await loadMoreRankData(
                response: monthlyResponse,
                period: .monthly,
                page: currentMonthlyPage
            )
            monthlyRankUsers.append(contentsOf: rankDatas.values)
        }
        
        if rankDatas.isEmpty {
            updateRemainPage(hasMoreData: false)
        }
        
        isLoadingMore = false
    }
    
    func showMoreProgressView() -> Bool {
        checkOwnResponse() && checkRemainData()
    }
    
    private func checkOwnResponse() -> Bool {
        switch selectedPeriod {
        case .daily:
            !dailyResponse.rankDatas.isEmpty
        case .weekly:
            !weeklyResponse.rankDatas.isEmpty
        case .monthly:
            !monthlyResponse.rankDatas.isEmpty
        }
    }
    
    private func checkRemainData() -> Bool {
        switch selectedPeriod {
        case .daily:
            return remainDailyPage
        case .weekly:
            return remainWeeklyPage
        case .monthly:
            return remainMonthlyPage
        }
    }
    
    private func loadMoreRankData(response: RankResponse, period: RankPeriod, page: Int) async -> [Int: RankUser] {
        var tempUsers: [Int: RankUser] = [:]
        
        let startIndex = (page - 1) * pageSize
        let endIndex = min(page * pageSize, response.rankDatas.count)
        
        guard startIndex < endIndex else {
            updateRemainPage(hasMoreData: false)
            return tempUsers
        }
        
        let rankDataSlice = response.rankDatas[startIndex..<endIndex]
        
        await withTaskGroup(of: (Int, RankUser?).self) { group in
            for (index, userData) in rankDataSlice.enumerated() {
                group.addTask {
                    let rankUser = await self.fetchAndCreateRankUser(userData: userData)
                    return (index, rankUser)
                }
            }
            
            for await (index, rankUser) in group {
                if let rankUser = rankUser {
                    tempUsers[startIndex + index] = rankUser
                }
            }
        }
        
        return tempUsers
    }
    
    private func updateRemainPage(hasMoreData: Bool) {
        switch selectedPeriod {
        case .daily:
            remainDailyPage = hasMoreData
        case .weekly:
            remainWeeklyPage = hasMoreData
        case .monthly:
            remainMonthlyPage = hasMoreData
        }
    }
}
