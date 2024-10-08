//
//  NumberSearchView.swift
//  MainFeature
//
//  Created by 최동호 on 9/5/24.
//  Copyright © 2024 Svanguard. All rights reserved.
//

import Common
import DesignSystem
import Kingfisher
import SwiftUI

struct NumberSearchView: View {
    @StateObject var viewModel = NumberSearchViewModel()
    
    var body: some View {
        if #available(iOS 17.0, *) {
            NumberSearch
                .searchable(
                    text: $viewModel.searchQuery,
                    isPresented: $viewModel.isSearchFieldFocused,
                    placement: .navigationBarDrawer(displayMode: .always),
                    prompt: "병영번호 검색"
                )
                .keyboardType(.numberPad)
        } else {
            NumberSearch
                .searchable(
                    text: $viewModel.searchQuery,
                    placement: .navigationBarDrawer(displayMode: .always),
                    prompt: "병영번호 검색"
                )
                .keyboardType(.numberPad)
        }
    }
    
    @ViewBuilder
    private var NumberSearch: some View {
        VStack {
            if viewModel.searchQuery.isEmpty {
                Text("병영번호로 핵의심 유저를 검색하세요")
                    .foregroundStyle(.gray)
                    .font(.body)
                    .padding()
            } else if viewModel.isLoading {
                ProgressView()
            } else if !viewModel.showResult {
                Text("\(viewModel.searchQuery)는 확인되지 않는 병영입니다.")
                    .foregroundStyle(.gray)
                    .font(.body)
                    .padding()
            } else {
                List {
                    NavigationLink(destination: {
                        resultView(userNick: viewModel.userData.userName, userSuddenNumber: viewModel.userData.suddenNumber)
                            .reviewCounter()
                            .navigationTitle("조회 결과")
                            .navigationBarTitleDisplayMode(.inline)
                    }) {
                        UserRowView(user: viewModel.userData)
                    }
                }
                .listStyle(.plain)
            }
        }
        .navigationTitle("병영번호 검색")
        .navigationBarTitleDisplayMode(.inline)
    }
    
    @ViewBuilder
    private func resultView(userNick: String, userSuddenNumber: Int) -> some View {
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
