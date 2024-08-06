//
//  RinkViewModel.swift
//  RankFeature
//
//  Created by 강치우 on 8/6/24.
//  Copyright © 2024 Svanguard. All rights reserved.
//

import Foundation
import Combine

final class RankViewModel: ObservableObject {
    @Published var text: String = ""
    @Published var users: [RankUser] = []
    @Published var isLoading: Bool = true
    @Published var isLoadingMore: Bool = false
    
    private var cancellables = Set<AnyCancellable>()
    private var currentPage: Int = 1
    private let pageSize: Int = 10
    
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
        self.users = Array(RankUser.dummyData.prefix(pageSize))
        self.isLoading = false
    }
    
    // MARK: 새로고침 로직
    func refreshData() {
        
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
}
