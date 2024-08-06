//
//  RankView.swift
//  RankFeature
//
//  Created by 강치우 on 8/4/24.
//  Copyright © 2024 Svanguard. All rights reserved.
//

import DesignSystem
import SwiftUI

public struct RankView: View {
    @StateObject private var viewModel = RankViewModel()
    
    public init() { }
    
    public var body: some View {
        NavigationStack {
            VStack {
                if viewModel.isLoading {
                    ProgressView()
                } else {
                    List(viewModel.filteredUsers) { user in
                        Section {
                            RankUserListCell(user: user)
                        }
                        .listSectionSeparator(.hidden, edges: .top)
                    }
                    .listStyle(.plain)
                    .searchable(text: $viewModel.text, placement: .navigationBarDrawer(displayMode: .always), prompt: "검색")
                    .refreshable {
                        viewModel.refreshData()
                    }
                }
            }
            .navigationTitle("실시간랭킹")
            .navigationBarTitleDisplayMode(.large)
            .onAppear {
                viewModel.loadData()
            }
        }
    }
}

#Preview {
    RankView()
}
