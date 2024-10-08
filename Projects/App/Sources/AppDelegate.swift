//
//  AppDelegate.swift
//  App
//
//  Created by 최동호 on 8/19/24.
//  Copyright © 2024 Svanguard. All rights reserved.
//

import Core
import Data
import Domain
import NetworkService
import UIKit

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(
          _ application: UIApplication,
          didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil
      ) -> Bool {
          registerDependencies()
          return true
      }
    
    func registerDependencies() {
        let apiClientService: ApiClientService = ApiClientServiceImp()
        
        // MARK: - Repository
        let searchNumberRepository: SearchNumberRepository = SearchNumberRepositoryImp(apiClientService: apiClientService)
        let searchUsersRepository: SearchUsersRepository = SearchUsersRepositoryImp(apiClientService: apiClientService)
        let getRankDataRepository: GetRankDataRepository = GetRankDataRepositoryImp(apiClientService: apiClientService)
        let getProfileDataRepository: GetProfileDataRepository = GetProfileDataRepositoryImp(apiClientService: apiClientService)
        
        // MARK: - Store
        let rankDataStore: RankDataStore = RankDataStoreImp()
        
        // MARK: - Service
        let searchService: SearchService = SearchServiceImp(
            searchNumberRepository: searchNumberRepository,
            searchUsersRepository: searchUsersRepository,
            getProfileDataRepository: getProfileDataRepository
        )
        let rankService: RankService = RankServiceImp(
            searchNumberRepository: searchNumberRepository,
            getRankDataRepository: getRankDataRepository,
            getProfileDataRepository: getProfileDataRepository, 
            rankDataStore: rankDataStore
        )
        
        // MARK: - UseCase
        let searchUseCase: SearchUseCase = SearchUseCaseImp(service: searchService)
        let rankUseCase: RankUseCase = RankUseCaseImp(rankService: rankService)
        
        // MARK: - Register
        DIContainer.register(
            type: SearchUseCase.self,
            searchUseCase
        )
        
        DIContainer.register(
            type: RankUseCase.self,
            rankUseCase
        )
    
    }
}
