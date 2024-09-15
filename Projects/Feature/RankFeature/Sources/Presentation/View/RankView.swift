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
                                NavigationLink {
                                    resultView(userNick: user.username)
                                        .onAppear {
                                            viewModel.searchNumber(userSuddenNumber: user.suddenNumber)
                                        }
                                } label: {
                                    RankUserListCell(user: user)
                                }
                            }
                        }
                        
                        if viewModel.hasMoreData {
                            ProgressView()
                                .frame(maxWidth: .infinity, alignment: .center)
                                .onAppear {
                                    viewModel.loadMoreData()
                                }
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
            .confirmationDialog("", isPresented: $viewModel.showActionSheet, titleVisibility: .hidden, actions: {
                Button {
                    viewModel.selectedPeriod = .daily
                    viewModel.loadData()
                } label: {
                    Text("일간")
                }
                
                Button {
                    viewModel.selectedPeriod = .weekly
                    viewModel.loadData()
                } label: {
                    Text("주간")
                }
                
                Button {
                    viewModel.selectedPeriod = .monthly
                    viewModel.loadData()
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
    
    @ViewBuilder
    private func resultView(userNick: String) -> some View {
        if viewModel.userFetchLoading {
            ProgressView()
        } else {
            switch viewModel.resultType {
            case .clean:
                ResultView(
                    title: "전과 기록이 없습니다",
                    content: "\(userNick)님은 현재 뱅가드에 등록되어 있지 않습니다.",
                    image: .init(
                        content: "person.fill.checkmark",
                        tint: .green,
                        foreground: .white
                    )
                )
                .presentationDetents([.height(280)])
                .interactiveDismissDisabled()
                
            case .restriction:
                ResultView(
                    title: "게임 이용 제한 유저 발견!",
                    content: "\(userNick)님은 현재 게임 이용 제한 상태입니다.\n제재 기간: \(viewModel.userPunishDate)",
                    image: .init(
                        content: "exclamationmark.triangle.fill",
                        tint: .red,
                        foreground: .white
                    )
                )
                .presentationDetents([.height(280)])
                .interactiveDismissDisabled()
                
            case .protection:
                ResultView(
                    title: "보호모드 유저 발견!",
                    content: "\(userNick)님은 현재 보호모드 상태입니다.\n제한 기간: \(viewModel.userPunishDate)",
                    image: .init(
                        content: "exclamationmark.triangle.fill",
                        tint: .red,
                        foreground: .white
                    )
                )
                .presentationDetents([.height(280)])
                .interactiveDismissDisabled()
                
            case .success:
                ResultView(
                    title: "핵의심 유저 발견!",
                    content: "\(userNick)님은 다른 유저의 제보로 뱅가드에 등록되어 있습니다.",
                    image: .init(
                        content: "exclamationmark.triangle.fill",
                        tint: .orange,
                        foreground: .white
                    )
                )
                .presentationDetents([.height(280)])
                .interactiveDismissDisabled()
                
            case .error:
                ResultView(
                    title: "검색 결과가 없습니다",
                    content: "\(userNick)님의 검색 결과가 없습니다.",
                    image: .init(
                        content: "person.fill.questionmark",
                        tint: .blue,
                        foreground: .white
                    )
                )
                .presentationDetents([.height(330)])
                .interactiveDismissDisabled()
                
                
            }
        }
    }
}
