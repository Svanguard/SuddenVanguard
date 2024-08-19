//
//  UserSearchView.swift
//  MainFeature
//
//  Created by 강치우 on 8/19/24.
//  Copyright © 2024 Svanguard. All rights reserved.
//

import SwiftUI

struct UserSearchView: View {
    @StateObject private var viewModel = UserSearchViewModel()

    var body: some View {
        NavigationStack {
            VStack {
                if viewModel.isLoading {
                    ProgressView()
                        .scaleEffect(1.5)
                } else if viewModel.users.isEmpty {
                    List {
                        Section(header: Text("검색 기록")) {
                            ForEach(viewModel.searchHistory, id: \.self) { history in
                                Text(history)
                                    .onTapGesture {
                                        viewModel.searchQuery = history
                                    }
                            }
                            .onDelete(perform: viewModel.deleteSearchHistory)
                        }
                    }
                    .listStyle(.plain)
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
            .searchable(text: $viewModel.searchQuery, placement: .navigationBarDrawer(displayMode: .always), prompt: "닉네임 검색")
        }
    }
}
