//
//  RankServiceImp.swift
//  Data
//
//  Created by 최동호 on 8/29/24.
//  Copyright © 2024 Svanguard. All rights reserved.
//

import Combine
import Common
import Domain

public final class RankServiceImp: RankService {
    private let searchNumberRepository: SearchNumberRepository
    private let getRankDataRepository: GetRankDataRepository
    private let getProfileDataRepository: GetProfileDataRepository
    private let rankDataStore: RankDataStore
    
    private var currentDailyPage: Int = 0
    private var currentWeeklyPage: Int = 0
    private var currentMonthlyPage: Int = 0
    
    private var remainDailyPage: Bool = true
    private var remainWeeklyPage: Bool = true
    private var remainMonthlyPage: Bool = true
    private let pageSize: Int = 10
    
    public init(
        searchNumberRepository: SearchNumberRepository,
        getRankDataRepository: GetRankDataRepository,
        getProfileDataRepository: GetProfileDataRepository,
        rankDataStore: RankDataStore
    ) {
        self.searchNumberRepository = searchNumberRepository
        self.getRankDataRepository = getRankDataRepository
        self.getProfileDataRepository = getProfileDataRepository
        self.rankDataStore = rankDataStore
    }
    
    public func loadRankData(period: RankPeriod) -> AnyPublisher<([RankUser], Bool), Error> {
        if let cachedResponse = rankDataStore.getRankResponse(period: period) {
            // 캐싱된 데이터를 사용하고, 현재 페이지에 해당하는 데이터를 반환
            let startIndex = getPageForPeriod(period: period) * pageSize
            let endIndex = startIndex + pageSize
            let pagedData = cachedResponse.rankDatas[startIndex..<min(endIndex, cachedResponse.rankDatas.count)]
            
            let hasMoreData = endIndex < cachedResponse.rankDatas.count
            
            if pagedData.isEmpty {
                return Just(([], false)).setFailureType(to: Error.self).eraseToAnyPublisher()
            } else {
                incrementPageForPeriod(period: period)
                return Just((Array(pagedData), hasMoreData))
                    .setFailureType(to: Error.self)
                    .flatMap { rankDatas, hasMoreData in
                        self.getProfileDataForRankUsers(rankDatas)
                            .map { ($0, hasMoreData) }
                    }
                    .eraseToAnyPublisher()
            }
        } else {
            // 캐싱 데이터 없을 시
            return getRankDataRepository.getRankData(request: RankRequest(requestType: convertToRankRequestType(period: period)))
                .map { response in
                    self.rankDataStore.saveRankResponse(response: response, period: period)
                    let hasMoreData = response.rankDatas.count > self.pageSize
                    return (response.rankDatas, hasMoreData)
                }
                .flatMap { rankDatas, hasMoreData in
                    self.getProfileDataForRankUsers(Array(rankDatas.prefix(self.pageSize)))
                        .map { ($0, hasMoreData) }
                }
                .handleEvents(receiveCompletion: { _ in
                    self.incrementPageForPeriod(period: period)
                })
                .eraseToAnyPublisher()
        }
    }
    
    public func refreshRankData(period: RankPeriod) -> AnyPublisher<([RankUser], Bool), Error> {
        clearPageForPeriod(period: period)
        rankDataStore.resetRankResponse(period: period)
        return loadRankData(period: period)
    }
    
    public func loadMoreRankData(period: RankPeriod) -> AnyPublisher<([RankUser], Bool), Error> {
        return loadRankData(period: period)
    }
    
    
    public func getPunishData(request: SearchNumberRequest) -> AnyPublisher<(PunishResultType, String), Error> {
        return searchNumberRepository.searchNumber(request: request)
            .map { response in
                let resultType: PunishResultType
                let punishDate: String
                
                switch response.punishType {
                case "restriction":
                    resultType = .restriction
                    punishDate = response.punishDate
                case "protection":
                    resultType = .protection
                    punishDate = response.punishDate
                default:
                    if response.registerFg {
                        resultType = .success
                    } else {
                        resultType = .clean
                    }
                    punishDate = ""
                }
                
                return (resultType, punishDate)
            }
            .eraseToAnyPublisher()
    }
    
    // 프로필 데이터를 가져와 RankUser로 변환하는 함수
    private func getProfileDataForRankUsers(_ rankDatas: [UserCountData]) -> AnyPublisher<[RankUser], Error> {
        let fetchRankUserPublishers = rankDatas.map { userData in
            self.getProfileDataRepository.getProfileData(request: GetProfileRequest(suddenNumber: userData.userNexonSn))
                .map { profileResponse in
                    RankUser(
                        username: profileResponse.userName,
                        suddenNumber: userData.userNexonSn,
                        count: userData.count,
                        userImage: profileResponse.userImage
                    )
                }
                .eraseToAnyPublisher()
        }
        
        return Publishers.MergeMany(fetchRankUserPublishers)
            .collect()
            .eraseToAnyPublisher()
    }
    
    private func convertToRankRequestType(period: RankPeriod) -> RankRequestType {
        switch period {
        case .daily:
            return .daily
        case .weekly:
            return .weekly
        case .monthly:
            return .monthly
        }
    }
    
    private func incrementPageForPeriod(period: RankPeriod) {
        switch period {
        case .daily:
            currentDailyPage += 1
        case .weekly:
            currentWeeklyPage += 1
        case .monthly:
            currentMonthlyPage += 1
        }
    }
    
    private func clearPageForPeriod(period: RankPeriod) {
        switch period {
        case .daily:
            currentDailyPage = 0
            remainDailyPage = true
        case .weekly:
            currentWeeklyPage = 0
            remainWeeklyPage = true
        case .monthly:
            currentMonthlyPage = 0
            remainMonthlyPage = true
        }
    }
    
    private func setRemainPage(period: RankPeriod, remain: Bool) {
        switch period {
        case .daily:
            remainDailyPage = remain
        case .weekly:
            remainWeeklyPage = remain
        case .monthly:
            remainMonthlyPage = remain
        }
    }
    
    private func getPageForPeriod(period: RankPeriod) -> Int {
        switch period {
        case .daily:
            return currentDailyPage
        case .weekly:
            return currentWeeklyPage
        case .monthly:
            return currentMonthlyPage
        }
    }
}
