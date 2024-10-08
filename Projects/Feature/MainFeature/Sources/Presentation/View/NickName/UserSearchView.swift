//
//  UserSearchView.swift
//  MainFeature
//
//  Created by 강치우 on 8/19/24.
//  Copyright © 2024 Svanguard. All rights reserved.
//

import Common
import DesignSystem
import SwiftUI

struct UserSearchView: View {
    @StateObject var viewModel = UserSearchViewModel()
    
    var body: some View {
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
                        resultView(userNick: user.userName, userSuddenNumber: user.suddenNumber)
                            .onAppear {
                                viewModel.searchNumber(userSuddenNumber: user.suddenNumber)
                                viewModel.addUserToSearchHistory(user)
                            }
                            .reviewCounter()
                            .navigationTitle("조회 결과")
                            .navigationBarTitleDisplayMode(.inline)
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
    private func resultView(userNick: String, userSuddenNumber: Int) -> some View {
        if viewModel.userFetchLoading {
            ProgressView()
        } else {
            let linkURL = URL(string: "https://barracks.sa.nexon.com/\(userSuddenNumber)/match")!
            
            switch viewModel.resultType {
            case .clean:
                ResultView(
                    title: "전과 기록이 없습니다",
                    content: "\(userNick)님은 현재\n뱅가드에 등록되어 있지 않습니다.",
                    image: .init(
                        content: "person.fill.checkmark",
                        tint: .green,
                        foreground: .white
                    ),
                    showLink: true,
                    linkURL: linkURL
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
                    ),
                    showLink: true,
                    linkURL: linkURL
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
                    ),
                    showLink: true,
                    linkURL: linkURL
                )
                .presentationDetents([.height(280)])
                .interactiveDismissDisabled()
                
            case .success:
                ResultView(
                    title: "핵의심 유저 발견!",
                    content: "\(userNick)님은 다른 유저의 제보로\n뱅가드에 등록되어 있습니다.",
                    image: .init(
                        content: "exclamationmark.triangle.fill",
                        tint: .orange,
                        foreground: .white
                    ),
                    showLink: true,
                    linkURL: linkURL
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
                    ),
                    showLink: false // 링크가 필요 없는 경우
                )
                .presentationDetents([.height(330)])
                .interactiveDismissDisabled()
            }
        }
    }
}
