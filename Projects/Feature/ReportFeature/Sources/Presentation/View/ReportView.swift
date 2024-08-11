//
//  ReportView.swift
//  ReportFeature
//
//  Created by 강치우 on 8/3/24.
//  Copyright © 2024 Svanguard. All rights reserved.
//

import DesignSystem
import MessageUI
import SwiftUI

public struct ReportView: View {
    @StateObject private var viewModel = ReportViewModel()
    
    public init() { }
    
    public var body: some View {
        NavigationStack {
            VStack {
                ScrollViewReader { scrollViewProxy in
                    List {
                        Section {
                            TabView {
                                ForEach(viewModel.images.indices, id: \.self) { index in
                                    Image(uiImage: viewModel.images[index].imageName)
                                        .resizable()
                                        .cornerRadius(10)
                                        .scaledToFit()
                                        .clipped()
                                        .overlay {
                                            RoundedRectangle(cornerRadius: 10)
                                                .stroke(DesignSystemAsset.searchBorderColor.swiftUIColor, lineWidth: 1.5)
                                        }
                                        .padding(.horizontal, 3)
                                }
                            }
                            .tabViewStyle(.page(indexDisplayMode: .always))
                            .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height / 4)
                        } header: {
                            Text("핵 의심 스크린샷")
                        }
                        
                        Section {
                            ForEach(viewModel.items) { item in
                                DisclosureGroup(
                                    isExpanded: Binding(
                                        get: { viewModel.isSectionExpanded(item.id) },
                                        set: { isExpanded in
                                            viewModel.toggleSection(item.id)
                                            if isExpanded {
                                                DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                                                    withAnimation {
                                                        scrollViewProxy.scrollTo(item.id, anchor: .top)
                                                    }
                                                }
                                            }
                                        }
                                    ),
                                    content: {
                                        Text(item.subtitle)
                                            .font(.subheadline)
                                    },
                                    label: {
                                        HStack {
                                            Image(systemName: "questionmark")
                                            
                                            Text(item.title)
                                                .fontWeight(.medium)
                                        }
                                    }
                                )
                                .id(item.id)
                            }
                        } header: {
                            Text("자주 묻는 질문 (FAQ)")
                        }
                        .listSectionSeparator(.hidden)
                    }
                    .tint(.primary)
                    .listStyle(.inset)
                    .scrollIndicators(.hidden)
                    .navigationTitle("제보하기")
                    .navigationBarTitleDisplayMode(.inline)
                    .navigationBarItems(trailing: Button {
                        viewModel.mailButtonTapped()
                    } label: {
                        Text("제보")
                            .foregroundStyle(.red)
                    })
                }
            }
        }
        .sheet(isPresented: $viewModel.showMailView) {
            MailView(isShowing: $viewModel.showMailView, mailContent: viewModel.mailContent)
        }
        .alert(isPresented: $viewModel.showMailErrorAlert) {
            Alert(
                title: Text("메일 전송 불가"),
                message: Text("메일 계정이 설정되어 있지 않거나, 메일 전송이 불가능한 상태입니다."),
                dismissButton: .default(Text("확인"))
            )
        }
    }
}
