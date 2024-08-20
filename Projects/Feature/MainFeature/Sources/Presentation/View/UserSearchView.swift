//
//  UserSearchView.swift
//  MainFeature
//
//  Created by 강치우 on 8/19/24.
//  Copyright © 2024 Svanguard. All rights reserved.
//

import SwiftUI

struct UserSearchView: View {
    @StateObject var viewModel = UserSearchViewModel()

    var body: some View {
        NavigationStack {
            if #available(iOS 17.0, *) {
                UserSearch
                    .searchable(text: $viewModel.searchQuery, isPresented: $viewModel.isSearchFieldFocused, placement: .navigationBarDrawer(displayMode: .always), prompt: "닉네임 검색")
            } else {
                UserSearch
                    .searchable(text: $viewModel.searchQuery, placement: .navigationBarDrawer(displayMode: .always), prompt: "닉네임 검색")
            }
        }
        .alert(isPresented: $viewModel.showAlert) {
            Alert(
                title: Text("전체 삭제"),
                message: Text("최근 검색어를 모두 삭제하시겠습니까?"),
                primaryButton: .destructive(Text("삭제")) {
                    viewModel.clearSearchHistory()
                },
                secondaryButton: .cancel(Text("취소"))
            )
        }
    }
    
    @ViewBuilder
    private var UserSearch: some View {
        VStack {
            if viewModel.isLoading {
                ProgressView()
            } else if viewModel.users.isEmpty {
                if viewModel.searchQuery.isEmpty && viewModel.searchHistory.isEmpty {
                    Text("최근 검색 내역이 없습니다")
                        .foregroundColor(.gray)
                        .font(.body)
                        .padding()
                } else if !viewModel.searchQuery.isEmpty && viewModel.users.isEmpty {
                    Text("검색 결과가 없습니다")
                        .foregroundColor(.gray)
                        .font(.body)
                        .padding()
                } else {
                    EmptyStateView(searchQuery: viewModel.searchQuery, searchHistory: viewModel.searchHistory, onTap: viewModel.performSearch, onDelete: viewModel.deleteSearchHistory)
                }
            } else {
                List(viewModel.users) { user in
                    NavigationLink(destination: {
                        resultView(userNick: user.user_nick)
                            .onAppear {
                                viewModel.addUserToSearchHistory(user)
                            }
                    }) {
                        UserRowView(user: user)
                    }
                }
                .listStyle(.plain)
            }
        }
        .onChange(of: viewModel.searchQuery) { _ in
            Task {
                await viewModel.searchUsers()
            }
        }
        .navigationTitle("유저 검색")
        .navigationBarTitleDisplayMode(.inline)
    }
    
    @ViewBuilder
    private func resultView(userNick: String) -> some View {
        switch viewModel.resultType {
        case .success:
            ResultView(
                title: "전과자 발견!",
                content: "\(userNick)님은 전과 기록이 있습니다.",
                image: .init(
                    content: "exclamationmark.triangle.fill",
                    tint: .red,
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
        }
    }
}