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
                HStack {
                    filterButton
                        .padding(.horizontal)
                    
                    Spacer()
                }
                
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
                            }
                        }
                        
                        if viewModel.showMoreProgressView() {
                            ProgressView()
                                .frame(maxWidth: .infinity, alignment: .center)
                                .onAppear {
                                    Task {
                                        await viewModel.loadMoreData()
                                    }
                                }
                        }
                    }
                    .listStyle(.plain)
                    .searchable(text: $viewModel.text, placement: .navigationBarDrawer(displayMode: .always), prompt: "검색")
                    .refreshable {
                        Task {
                           await viewModel.refreshData()
                        }
                    }
                }
            }
            .navigationTitle("실시간순위")
            .navigationBarTitleDisplayMode(.large)
            .confirmationDialog("", isPresented: $viewModel.showActionSheet, titleVisibility: .hidden, actions: {
                Button {
                    viewModel.selectedPeriod = .daily
                    Task {
                        await viewModel.loadData()
                    }
                } label: {
                    Text("일간")
                }
                
                Button {
                    viewModel.selectedPeriod = .weekly
                    Task {
                        await viewModel.loadData()
                    }
                } label: {
                    Text("주간")
                }
                
                Button {
                    viewModel.selectedPeriod = .monthly
                    Task {
                        await viewModel.loadData()
                    }
                } label: {
                    Text("월간")
                }
                
                Button("닫기", role: .cancel) { }
            })
        }
    }
    
    private var filterButton: some View {
        Button {
            viewModel.showActionSheet = true
        } label: {
            HStack(spacing: 2) {
                Text(viewModel.selectedPeriod.displayName)
                    .font(.subheadline)
                    .fontWeight(.semibold)
                    
                Image(systemName: "chevron.down")
                    .font(.caption2)
            }
            .foregroundStyle(Color(.systemGray))
        }
    }
    
    private func headerView(for rank: Int) -> some View {
        Text("\(rank) 위")
            .font(rank < 4 ? .title3 : .callout)
            .fontWeight(.semibold)
    }
}
