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
    
    @Published var user: SearchUserData = .init(suddenNumber: 0, userName: "", userImage: "")
    @Published var resultType: PunishResultType = .clean
    @Published var userPunishDate: String = ""
    @Published var userFetchLoading = false
    
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
    func loadData(forceLoad: Bool = false) {
        isLoading = true
        if !isEmptyRankUsers() && !forceLoad {
            isLoading = false
        } else {
            checkIsRankResponse()
                .receive(on: DispatchQueue.main)
                .sink(receiveCompletion: { [weak self] completion in
                    if case .failure(let error) = completion {
                        print("랭크 데이터 패치 실패: \(error)")
                        self?.isLoading = false
                    }
                }, receiveValue: { [weak self] in
                    self?.isLoading = false
                })
                .store(in: &cancellables)
        }
    }
    
    // MARK: 새로고침 로직
    func refreshData() {
        switch selectedPeriod {
        case .daily:
            currentDailyPage = 0
            dailyResponse = .init(rankDatas: [])
        case .weekly:
            currentWeeklyPage = 0
            weeklyResponse = .init(rankDatas: [])
        case .monthly:
            currentMonthlyPage = 0
            monthlyResponse = .init(rankDatas: [])
        }

        loadData(forceLoad: true)
    }
    
    // MARK: Rank 데이터 가져오기
    func getRankData() -> AnyPublisher<Void, Error> {
        let rankPublisher: AnyPublisher<RankResponse, Error>

        switch selectedPeriod {
        case .daily:
            rankPublisher = rankUseCase.getRankData(request: .init(requestType: .daily))
        case .weekly:
            rankPublisher = rankUseCase.getRankData(request: .init(requestType: .weekly))
        case .monthly:
            rankPublisher = rankUseCase.getRankData(request: .init(requestType: .monthly))
        }
        
        return rankPublisher
            .map { [weak self] response in
                guard let self = self else { return }
                self.updateRankResponse(response: response)
            }
            .flatMap { [weak self] in
                self?.getRankDataByPeriod() ?? Empty().eraseToAnyPublisher()
            }
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
    
    // MARK: 선택된 기간에 따라 Rank 데이터 저장
    private func updateRankResponse(response: RankResponse) {
          switch selectedPeriod {
          case .daily:
              dailyResponse = response
          case .weekly:
              weeklyResponse = response
          case .monthly:
              monthlyResponse = response
          }
      }
    
    // MARK: 기간에 따른 Rank 사용자 데이터 가져오기
    private func getRankDataByPeriod() -> AnyPublisher<Void, Error> {
           let rankDataPublisher: AnyPublisher<[RankUser], Error>

           switch selectedPeriod {
           case .daily:
               rankDataPublisher = getRankUsers(rankDatas: dailyResponse.rankDatas, period: .daily)
               currentDailyPage += 2
           case .weekly:
               rankDataPublisher = getRankUsers(rankDatas: weeklyResponse.rankDatas, period: .weekly)
               currentWeeklyPage += 2
           case .monthly:
               rankDataPublisher = getRankUsers(rankDatas: monthlyResponse.rankDatas, period: .monthly)
               currentMonthlyPage += 2
           }

           return rankDataPublisher
               .map { [weak self] users in
                   guard let self = self else { return }
                   self.updateRankUsers(users: users)
               }
               .eraseToAnyPublisher()
       }
    
    // MARK: 선택된 기간에 따른 Rank 데이터 체크
    private func checkIsRankResponse() -> AnyPublisher<Void, Error> {
        let rankPublisher: AnyPublisher<Void, Error>
        switch selectedPeriod {
            case .daily:
                rankPublisher = dailyResponse.rankDatas.isEmpty ?
            getRankData().map { _ in () }.eraseToAnyPublisher() :
            Just(()).setFailureType(to: Error.self).eraseToAnyPublisher()
            case .weekly:
                rankPublisher = weeklyResponse.rankDatas.isEmpty ?
            getRankData().map { _ in () }.eraseToAnyPublisher() :
            Just(()).setFailureType(to: Error.self).eraseToAnyPublisher()
            case .monthly:
                rankPublisher = monthlyResponse.rankDatas.isEmpty ?
            getRankData().map { _ in () }.eraseToAnyPublisher() :
            Just(()).setFailureType(to: Error.self).eraseToAnyPublisher()
            }
        return rankPublisher
    }
    
    // Rank 사용자 데이터 업데이트
    private func updateRankUsers(users: [RankUser]) {
        switch selectedPeriod {
        case .daily:
            dailyRankUsers = users
        case .weekly:
            weeklyRankUsers = users
        case .monthly:
            monthlyRankUsers = users
        }
        isLoading = false
    }
    
    // Rank 사용자 가져오기
    private func getRankUsers(
        rankDatas: [UserCountData],
        period: RankPeriod
    ) -> AnyPublisher<[RankUser], Error> {
         let fetchRankUserPublishers = rankDatas.prefix(20).enumerated().map { index, userData in
             self.fetchAndCreateRankUser(userData: userData)
                 .map { user in (index, user) }
                 .eraseToAnyPublisher()
         }
         
         return Publishers.MergeMany(fetchRankUserPublishers)
             .collect()
             .map { $0.compactMap { $0.1 }.sorted { $0.count > $1.count } }
             .receive(on: DispatchQueue.main)
             .eraseToAnyPublisher()
     }
    
    // RankUser 객체 생성
    private func fetchAndCreateRankUser(
        userData: UserCountData
    ) -> AnyPublisher<RankUser?, Error> {
        rankUseCase.getProfileData(request: .init(suddenNumber: userData.userNexonSn))
            .map { profileResponse in
                RankUser(
                    username: profileResponse.userName,
                    suddenNumber: userData.userNexonSn,
                    count: userData.count,
                    userImage: profileResponse.userImage
                )
            }
            .receive(on: DispatchQueue.main)
            .catch { _ in Just(nil).setFailureType(to: Error.self) }
            .eraseToAnyPublisher()
    }
    
    // Rank 사용자 데이터가 비어있는지 확인
    private func isEmptyRankUsers() -> Bool {
        switch selectedPeriod {
        case .daily:
            return dailyRankUsers.isEmpty
        case .weekly:
            return weeklyRankUsers.isEmpty
        case .monthly:
            return monthlyRankUsers.isEmpty
        }
    }
}

// MARK: - 무한스크롤
extension RankViewModel {
    // MARK: 무한 스크롤 로직
    func loadMoreData() {
        guard !isLoadingMore else { return }
        isLoadingMore = true
        
        let loadPublisher: AnyPublisher<[Int: RankUser], Error>

        switch selectedPeriod {
        case .daily:
            currentDailyPage += 1
            loadPublisher = loadMoreRankData(response: dailyResponse, period: .daily, page: currentDailyPage)
            
        case .weekly:
            currentWeeklyPage += 1
            loadPublisher = loadMoreRankData(response: weeklyResponse, period: .weekly, page: currentWeeklyPage)
            
        case .monthly:
            currentMonthlyPage += 1
            loadPublisher = loadMoreRankData(response: monthlyResponse, period: .monthly, page: currentMonthlyPage)
        }
        
        loadPublisher
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { [weak self] completion in
                guard let self = self else { return }
                if case .failure = completion {
                    self.updateRemainPage(hasMoreData: false)
                }
            }, receiveValue: { [weak self] newRankDatas in
                guard let self = self else { return }
                switch self.selectedPeriod {
                case .daily:
                    self.dailyRankUsers.append(contentsOf: newRankDatas.values)
                case .weekly:
                    self.weeklyRankUsers.append(contentsOf: newRankDatas.values)
                case .monthly:
                    self.monthlyRankUsers.append(contentsOf: newRankDatas.values)
                }
                self.isLoadingMore = false
            })
            .store(in: &cancellables)
    }
    
    // MARK: 추가 데이터가 있으면 Progress Show
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
    
    // MARK: 추가 Rank 데이터 로드
    private func loadMoreRankData(response: RankResponse, period: RankPeriod, page: Int) -> AnyPublisher<[Int: RankUser], Error> {
         let startIndex = (page - 1) * pageSize
         let endIndex = min(page * pageSize, response.rankDatas.count)

         guard startIndex < endIndex else {
             updateRemainPage(hasMoreData: false)
             return Just([:]).setFailureType(to: Error.self).eraseToAnyPublisher()
         }

         let rankDataSlice = response.rankDatas[startIndex..<endIndex]

         let fetchRankUserPublishers = rankDataSlice.enumerated().map { (index, userData) in
             fetchAndCreateRankUser(userData: userData)
                 .map { (startIndex + index, $0) }
                 .eraseToAnyPublisher()
         }

         return Publishers.MergeMany(fetchRankUserPublishers)
             .collect()
             .map { results in
                 results.reduce(into: [Int: RankUser]()) { (dict, tuple) in
                     if let user = tuple.1 {
                         dict[tuple.0] = user
                     }
                 }
             }
             .eraseToAnyPublisher()
     }
    
    // MARK: 남은 페이지 업데이트
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

// MARK: - 제재이력 검사
extension RankViewModel {
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
}
