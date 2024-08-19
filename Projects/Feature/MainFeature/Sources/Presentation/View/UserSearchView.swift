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
        .alert(isPresented: $showAlert) {
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
                if viewModel.searchHistory.isEmpty {
                    Text("최근 검색어 내역이 없습니다")
                        .foregroundColor(.gray)
                        .font(.callout)
                        .padding()
                } else {
                    List {
                        Section {
                            ForEach(viewModel.searchHistory, id: \.self) { history in
                                HStack {
                                    Image(systemName: "magnifyingglass.circle.fill")
                                        .foregroundColor(.gray)
                                    
                                    Text(history)
                                        .padding(.leading, 4)
                                    
                                    Spacer()
                                    Text(viewModel.formattedDate(for: Date()))
                                        .font(.subheadline)
                                        .foregroundColor(.gray)
                                }
                                .contentShape(Rectangle())
                                .onTapGesture {
                                    viewModel.performSearch(for: history)
                                }
                            }
                            .onDelete(perform: viewModel.deleteSearchHistory)
                        } header: {
                            searchHistoryHeaderView
                        }
                    }
                    .listStyle(.plain)
                }
            } else {
                List(viewModel.users) { user in
                    HStack {
                        AsyncImage(url: URL(string: user.user_img)) { phase in
                            switch phase {
                            case .empty:
                                ProgressView()
                            case .success(let image):
                                image
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: 50, height: 50)
                                    .clipShape(Circle())
                            case .failure:
                                Image(systemName: "person.fill")
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: 50, height: 50)
                                    .clipShape(Circle())
                            @unknown default:
                                EmptyView()
                            }
                        }
                        
                        VStack(alignment: .leading, spacing: 8) {
                            Text(user.user_nick)
                                .font(.headline)
                            
                            let formattedNexonSN = String(user.user_nexon_sn).replacingOccurrences(of: ",", with: "")
                            Text("병영 번호: \(formattedNexonSN)")
                                .font(.subheadline)
                                .lineLimit(1)
                                .minimumScaleFactor(0.5)
                        }
                        .padding(.leading, 8)
                    }
                }
                .listStyle(.plain)
            }
        }
        .navigationTitle("유저 검색")
        .navigationBarTitleDisplayMode(.inline)
    }
    
    private var searchHistoryHeaderView: some View {
        HStack {
            Text("최근 검색어")
                .font(.body)
            
            Spacer()
            
            if !viewModel.searchHistory.isEmpty {  // 검색 기록이 있을 때만 전체 삭제 버튼 표시
                Button(action: {
                    viewModel.showAlert = true
                }) {
                    Text("전체 삭제")
                        .foregroundStyle(Color(.systemGray2))
                }
            }
        }
        .padding(.vertical, 8)
    }
}
