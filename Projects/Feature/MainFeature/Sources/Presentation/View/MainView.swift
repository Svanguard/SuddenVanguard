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
    
    public var body: some View {
        NavigationStack {
            VStack {
                VStack {
                    
                    Spacer()
                    Image(uiImage: DesignSystemAsset.vanguardlogo.image)
                        .resizable()
                        .scaledToFit()
//                        .frame(height: 100)
//                        .padding(.horizontal, 50)
                    
                    Text("모든 서든러의 전과기록을 확인해 보세요!")
                        .foregroundColor(.white)
                        .font(.caption)
                        .fontWeight(.regular)
                    
                    HStack {
                        Spacer()
                        
                        NavigationLink {
                            UserSearchView()
                        } label: {
                            SearchFieldView(
                                placeHolder: "닉네임으로 검색",
                                opacityValue: 1.0
                            )
                        }
                        
                        Spacer()
                        
                        NavigationLink {
                            NumberSearchView()
                        } label: {
                            SearchFieldView(
                                placeHolder: "병영번호로 검색",
                                opacityValue: 0.2
                            )
                        }
                        
                        Spacer()
                    }
                    .padding(.bottom)
                    
                    Spacer()
                }
                .padding(.horizontal, 20)
                .padding(.bottom, 50)
                .background(
                    Image(uiImage: DesignSystemAsset.bg.image)
                        .resizable()
                        .scaledToFill()
                        .ignoresSafeArea()
                        .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
                )
                
                Spacer()
                
//                ScrollView {
//                    ForEach(0..<7) { index in
//                        Rectangle()
//                            .frame(height: 100)
//                            .foregroundStyle(Color(.darkGray))
//                            .overlay {
//                                Text("광고 문의")
//                                    .foregroundColor(.white)
//                            }
//                    }
//                }
//                .padding(.top, 62)
//                .scrollIndicators(.hidden)
            }
        }
    }
}
