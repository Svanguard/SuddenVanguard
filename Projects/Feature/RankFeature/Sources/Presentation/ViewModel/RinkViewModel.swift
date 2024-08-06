//
//  RinkViewModel.swift
//  RankFeature
//
//  Created by 강치우 on 8/6/24.
//  Copyright © 2024 Svanguard. All rights reserved.
//

import Foundation
import Combine

class RankViewModel: ObservableObject {
    @Published var text: String = ""
    @Published var users: [RankUser] = []
    @Published var isLoading: Bool = true
    
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        loadData()
    }
    
    // MARK: 필터링 로직
    var filteredUsers: [RankUser] {
        if text.isEmpty {
            return users.sorted { $0.frequency > $1.frequency }
        } else {
            return users.filter { $0.username.contains(text) || $0.userID.contains(text) }.sorted { $0.frequency > $1.frequency }
        }
    }
    
    // MARK: 처음 보여줄 데이터
    func loadData() {
        self.users = RankUser.dummyData
        self.isLoading = false
    }
    
    // MARK: 새로고침 로직
    func refreshData() {
        
    }
}
