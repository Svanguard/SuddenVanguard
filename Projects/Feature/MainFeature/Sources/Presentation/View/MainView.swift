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
        VStack {
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
                }
                
                HStack {
                    Image(systemName: "magnifyingglass")
                        .foregroundColor(.white)
                    
                    TextField("닉네임을 입력하세요.", text: $viewModel.text)
                        .foregroundColor(.white)
                        .tint(.white)
                        .submitLabel(.search)
                        .onTapGesture {
                            withAnimation {
                                viewModel.isEditing = true
                            }
                        }
                        .onSubmit {
                            viewModel.searchNickname()
                        }
                        .overlay {
                            HStack {
                                Spacer()
                                
                                if viewModel.isEditing && !viewModel.text.isEmpty {
                                    Button(action: {
                                        viewModel.text = ""
                                    }) {
                                        Image(systemName: "xmark.circle.fill")
                                            .foregroundColor(Color.gray)
                                            .frame(width: 35, height: 35)
                                    }
                                    .padding(.trailing, 5)
                                }
                            }
                        }
                }
                .padding()
                .border(DesignSystemAsset.searchBorderColor.swiftUIColor)
                .background(DesignSystemAsset.searchColor.swiftUIColor)
                .padding(.top, 20)
            }
            .padding(.horizontal, 20)
            .padding(.top, 50)
            .background(
                Image(uiImage: DesignSystemAsset.mainBg.image)
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
                        .foregroundColor(getColor(index: index))
                        .overlay {
                            Text("광고 문의")
                                .foregroundColor(.white)
                        }
                }
            }
            .padding(.top, 62)
            .scrollIndicators(.hidden)
        }
        .floatingBottomSheet(isPresented: $viewModel.showSheet) {
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
    
    public func getColor(index: Int) -> Color {
        switch index {
        case 0: return .yellow
        case 1: return .green
        case 2: return .pink
        case 3: return .indigo
        case 4: return .cyan
        case 5: return .brown
        default: return .black
        }
    }
}

#Preview {
    MainView()
}

