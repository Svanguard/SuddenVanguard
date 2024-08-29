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
        
        let searchNumberRepository: SearchNumberRepository = SearchNumberRepositoryImp(apiClientService: apiClientService)

        let searchUsersRepository: SearchUsersRepository = SearchUsersRepositoryImp(apiClientService: apiClientService)
        
        let searchService: SearchService = SearchServiceImp(
            searchNumberRepository: searchNumberRepository,
            searchUsersRepository: searchUsersRepository
        )
        
        let searchUseCase: SearchUseCase = SearchUseCaseImp(service: searchService)

        DIContainer.register(
            type: SearchUseCase.self,
            searchUseCase
        )
    
    }
}
