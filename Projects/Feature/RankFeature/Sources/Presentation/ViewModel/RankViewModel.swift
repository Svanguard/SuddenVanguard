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
    @Published var dailyRankUsers: [RankUser] = []
    @Published var weeklyRankUsers: [RankUser] = []
    @Published var monthlyRankUsers: [RankUser] = []
    @Published var isLoading: Bool = true
    @Published var showActionSheet = false
    @Published var selectedPeriod: RankPeriod = .monthly
    @Published var hasMoreData: Bool = false
    
    @Published var user: SearchUserData = .init(suddenNumber: 0, userName: "", userImage: "")
    @Published var resultType: PunishResultType = .clean
    @Published var userPunishDate: String = ""
    @Published var userFetchLoading = false
    
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        loadData()
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
        let filtered = text.isEmpty ? sortedUsers : sortedUsers.filter { $0.username.contains(text) }
        
        return filtered
    }
    
    var isSearching: Bool {
        return !text.isEmpty
    }
    
    // MARK: 선택된 기간에 따른 데이터 로드
    func loadData() {
        isLoading = true
        rankUseCase.loadRankData(period: selectedPeriod)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { [weak self] completion in
                if case .failure(let error) = completion {
                    print("랭크 데이터 패치 실패: \(error)")
                    self?.isLoading = false
                }
            }, receiveValue: { [weak self] (rankUsers, hasMoreData) in
                self?.updateRankUsers(users: rankUsers)
                self?.hasMoreData = hasMoreData
                self?.isLoading = false
            })
            .store(in: &cancellables)
    }
    
    // MARK: 새로고침 로직
    func refreshData() {
        isLoading = true
        rankUseCase.refreshRankData(period: selectedPeriod)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { [weak self] completion in
                if case .failure(let error) = completion {
                    print("랭크 데이터 새로고침 실패: \(error)")
                    self?.isLoading = false
                }
            }, receiveValue: { [weak self] (rankUsers, hasMoreData) in
                self?.updateRankUsers(users: rankUsers)
                self?.hasMoreData = hasMoreData
                self?.isLoading = false
            })
            .store(in: &cancellables)
    }
    
    // MARK: 무한 스크롤 로직
    func loadMoreData() {
        guard hasMoreData else { return }
        
        rankUseCase.loadMoreRankData(period: selectedPeriod)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                if case .failure = completion {
                    print("추가 데이터 로드 실패")
                }
            }, receiveValue: { [weak self] (newRankUsers, hasMoreData) in
                self?.appendRankUsers(newUsers: newRankUsers)
                self?.hasMoreData = hasMoreData
            })
            .store(in: &cancellables)
    }
    
    // MARK: - 제재이력 검사
    func searchNumber(userSuddenNumber: Int) {
        guard userSuddenNumber != 0 else {
            return
        }
        userFetchLoading = true
        
        rankUseCase.getPunishData(request: .init(suddenNumber: userSuddenNumber))
            .receive(on: DispatchQueue.main)
            .sink { [weak self] completion in
                guard let self = self else { return }
                self.userFetchLoading = false
                if case .failure(let error) = completion {
                    print("번호로 서버에서 데이터 가져오기 에러: \(error)")
                }
            } receiveValue: { [weak self] (resultType, punishDate) in
                guard let self = self else { return }
                self.resultType = resultType
                self.userPunishDate = punishDate
                self.userFetchLoading = false
                
                self.userFetchLoading = false
            }
            .store(in: &cancellables)
    }
    
    // MARK: Rank 사용자 데이터 업데이트
    private func updateRankUsers(users: [RankUser]) {
        switch selectedPeriod {
        case .daily:
            dailyRankUsers = users
        case .weekly:
            weeklyRankUsers = users
        case .monthly:
            monthlyRankUsers = users
        }
    }
    
    // MARK: Rank 사용자 데이터 추가 (무한스크롤)
    private func appendRankUsers(newUsers: [RankUser]) {
        switch selectedPeriod {
        case .daily:
            dailyRankUsers.append(contentsOf: newUsers)
        case .weekly:
            weeklyRankUsers.append(contentsOf: newUsers)
        case .monthly:
            monthlyRankUsers.append(contentsOf: newUsers)
        }
    }
}
