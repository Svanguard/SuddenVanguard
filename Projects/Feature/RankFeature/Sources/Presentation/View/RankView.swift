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
    public init() { }
    
    @StateObject private var viewModel = RankViewModel()
    
    public var body: some View {
        NavigationStack {
            VStack {
                if viewModel.isLoading {
                    Spacer()
                    
                    ProgressView()
                        .progressViewStyle(CircularProgressViewStyle())
                        .scaleEffect(1.5)
                    
                    Spacer()
                } else {
                    List {
                        ForEach(viewModel.filteredUsers.enumerated().map({ $0 }), id: \.1.id) { index, user in
                            Section(header: viewModel.isSearching ? nil : headerView(for: index + 1)) {
                                RankUserListCell(user: user)
                                    .onAppear {
                                        if viewModel.filteredUsers.last == user {
                                            viewModel.loadMoreData()
                                        }
                                    }
                            }
                        }
                        
                        if viewModel.isLoadingMore {
                            ProgressView()
                                .frame(maxWidth: .infinity, alignment: .center)
                        }
                    }
                    .listStyle(.plain)
                    .searchable(text: $viewModel.text, placement: .navigationBarDrawer(displayMode: .always), prompt: "검색")
                    .refreshable {
                        viewModel.refreshData()
                    }
                }
            }
            .navigationTitle("실시간순위")
            .navigationBarTitleDisplayMode(.large)
            .onAppear {
                viewModel.loadData()
            }
        }
    }
    
    private func headerView(for rank: Int) -> some View {
        Text("\(rank) 위")
            .font(rank < 4 ? .title3 : .callout)
            .fontWeight(.semibold)
    }
}

#Preview {
    RankView()
}
