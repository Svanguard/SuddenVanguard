//
//  UserSearchView.swift
//  MainFeature
//
//  Created by 강치우 on 8/19/24.
//  Copyright © 2024 Svanguard. All rights reserved.
//

import DesignSystem
import SwiftUI

struct UserSearchView: View {
    @StateObject var viewModel = UserSearchViewModel()

    var body: some View {
        NavigationStack {
            if #available(iOS 17.0, *) {
                UserSearch
                    .searchable(
                        text: $viewModel.searchQuery,
                        isPresented: $viewModel.isSearchFieldFocused,
                        placement: .navigationBarDrawer(displayMode: .always),
                        prompt: "닉네임 검색"
                    )
            } else {
                UserSearch
                    .searchable(
                        text: $viewModel.searchQuery,
                        placement: .navigationBarDrawer(displayMode: .always),
                        prompt: "닉네임 검색"
                    )
            }
        }
    }
    
    @ViewBuilder
    private var UserSearch: some View {
        VStack {
            if viewModel.users.isEmpty {
                if viewModel.searchQuery.isEmpty && viewModel.searchHistory.isEmpty {
                    Text("최근 검색어 내역이 없습니다")
                        .foregroundStyle(.gray)
                        .font(.body)
                        .padding()
                } else if !viewModel.searchQuery.isEmpty && viewModel.users.isEmpty {
                    Text("검색 결과가 없습니다")
                        .foregroundStyle(.gray)
                        .font(.body)
                        .padding()
                } else {
                    EmptyStateView(
                        searchQuery: viewModel.searchQuery,
                        searchHistory: viewModel.searchHistory,
                        onTap: viewModel.performSearch,
                        onDelete: viewModel.deleteSearchHistory
                    )
                }
            } else {
                List(viewModel.users) { user in
                    NavigationLink(destination: {
                        resultView(userNick: user.userName)
                            .onAppear {
                                viewModel.searchNumber(userSuddenNumber: user.suddenNumber)
                                viewModel.addUserToSearchHistory(user)
                            }
                    }) {
                        UserRowView(user: user)
                    }
                }
                .listStyle(.plain)
            }
        }
        .navigationTitle("유저 검색")
        .navigationBarTitleDisplayMode(.inline)
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
