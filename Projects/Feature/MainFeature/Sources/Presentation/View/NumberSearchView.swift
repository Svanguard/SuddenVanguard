//
//  NumberSearchView.swift
//  MainFeature
//
//  Created by 최동호 on 9/5/24.
//  Copyright © 2024 Svanguard. All rights reserved.
//

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
        } else {
            NumberSearch
                .searchable(
                    text: $viewModel.searchQuery,
                    placement: .navigationBarDrawer(displayMode: .always),
                    prompt: "병영번호 검색"
                )
        }
    }
    
    @ViewBuilder
    private var NumberSearch: some View {
        VStack {
            if viewModel.isLoading {
                ProgressView()
            } else if viewModel.searchQuery.isEmpty {
                NoSearch
            } else {
                VStack {
                    UserProfile
                    resultView(userNick: viewModel.userData.userName)
                }
            }
        }
        .navigationTitle("병영번호 검색")
        .navigationBarTitleDisplayMode(.inline)
    }
    
    @ViewBuilder
    private var NoSearch: some View {
        VStack {
            Text("병영번호로 핵의심 유저를 검색하세요")
        }
    }
    
    @ViewBuilder
    private var UserProfile: some View {
        HStack {
            KFImage(URL(string: viewModel.userData.userImage))
                .placeholder {
                    Image(systemName: "person.fill")
                        .resizable()
                        .scaledToFill()
                        .frame(width: 100, height: 100)
                        .clipShape(Circle())
                }
                .resizable()
                .scaledToFill()
                .frame(width: 100, height: 100)
                .clipShape(Circle())
            
            VStack(alignment: .leading, spacing: 8) {
                Text(viewModel.userData.userName)
                    .font(.headline)
                
                let formattedNexonSN = String(viewModel.userData.suddenNumber).replacingOccurrences(of: ",", with: "")
                Text("병영 번호: \(formattedNexonSN)")
                    .font(.subheadline)
                    .lineLimit(1)
                    .minimumScaleFactor(0.5)
            }
            .padding(.leading, 8)
        }
    }
    
    @ViewBuilder
    private func resultView(userNick: String) -> some View {
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
                title: "게임 이용 제한 유저!",
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
                title: "보호모드 유저!",
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
                title: "핵의심 제보 유저!",
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
