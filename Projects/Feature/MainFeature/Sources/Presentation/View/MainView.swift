//
//  MainView.swift
//  MainFeature
//
//  Created by 강치우 on 8/3/24.
//  Copyright © 2024 Svanguard. All rights reserved.
//

import Common
import DesignSystem
import SwiftUI

public struct MainView: View {
    public init() { }
    
    @StateObject var viewModel = MainViewModel()
    
    public var body: some View {
        NavigationStack {
            VStack {
                VStack {
                    Image(uiImage: DesignSystemAsset.logo.image)
                        .resizable()
                        .scaledToFit()
                        .frame(height: 100)
                        .padding(.horizontal, 50)
                    
                    Text("모든 서든러의 전과기록을 확인해 보세요!")
                        .foregroundColor(.white)
                        .font(.caption)
                        .fontWeight(.regular)
                        .padding(.top, 10)
                    
                    SearchFieldView(
                        text: $viewModel.text,
                        isEditing: $viewModel.isEditing,
                        onSubmit: {
                            viewModel.searchNickname()
                        }
                    )
                    
                    NavigationLink {
                        UserSearchView()
                    } label: {
                        Text("이동")
                    }
                    
                }
                .padding(.horizontal, 20)
                .padding(.top, 50)
                .background(
                    Image(uiImage: DesignSystemAsset.bg.image)
                        .resizable()
                        .scaledToFill()
                        .ignoresSafeArea()
                        .padding(.bottom, -70)
                )
                
                Spacer()
                
                ScrollView {
                    ForEach(0..<7) { index in
                        Rectangle()
                            .frame(height: 100)
                            .foregroundStyle(Color(.darkGray))
                            .overlay {
                                Text("광고 문의")
                                    .foregroundColor(.white)
                            }
                    }
                }
                .padding(.top, 62)
                .scrollIndicators(.hidden)
                
            }
            .onTapGesture {
                UIApplication.shared.addTapGestureRecognizer()
            }
            .floatingBottomSheet(isPresented: $viewModel.showSheet) {
                sheetView
            }
        }
    }
    
    @ViewBuilder
    private var sheetView: some View {
        switch viewModel.sheetType {
        case .success:
            SheetView(
                title: "전과자 발견!",
                content: viewModel.result,
                image: .init(
                    content: "exclamationmark.triangle.fill",
                    tint: .red,
                    foreground: .white
                ),
                button1: .init(
                    content: "닫기",
                    tint: .red,
                    foreground: .white,
                    action: {
                        viewModel.showSheet = false
                    }
                )
            )
            .presentationDetents([.height(280)])
            .interactiveDismissDisabled()
            
        case .error:
            SheetView(
                title: "검색 결과가 없습니다",
                content: viewModel.result,
                image: .init(
                    content: "person.fill.questionmark",
                    tint: .blue,
                    foreground: .white
                ),
                button1: .init(
                    content: "검색하기",
                    tint: .blue,
                    foreground: .white,
                    action: {
                        viewModel.showSheet = false
                    }
                ),
                button2: .init(
                    content: "닫기",
                    tint: Color.primary.opacity(0.08),
                    foreground: Color.primary,
                    action: {
                        viewModel.showSheet = false
                    }
                )
            )
            .presentationDetents([.height(330)])
            .interactiveDismissDisabled()
            
        case .clean:
            SheetView(
                title: "전과 기록이 없습니다",
                content: viewModel.result,
                image: .init(
                    content: "person.fill.checkmark",
                    tint: .green,
                    foreground: .white
                ),
                button1: .init(
                    content: "닫기",
                    tint: .green,
                    foreground: .white,
                    action: {
                        viewModel.showSheet = false
                    }
                )
            )
            .presentationDetents([.height(280)])
            .interactiveDismissDisabled()
        }
    }
}
