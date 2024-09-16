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
    
    @State private var path = NavigationPath()
    
    public var body: some View {
        NavigationStack(path: $path) {
            TabViewItemWrapperView(path: $path, selection: .main) {
                VStack {
                    VStack {
                        Spacer()
                        
                        Image(uiImage: DesignSystemAsset.vanguardlogo.image)
                            .resizable()
                            .scaledToFit()
                        
                        Text("모든 서든러의 전과기록을 확인해 보세요!")
                            .foregroundColor(.white)
                            .font(.caption)
                            .fontWeight(.regular)
                        
                        HStack {
                            Spacer()
                            
                            NavigationLink(value: MainNavigationRoutes.nickname) {
                                SearchFieldView(
                                    placeHolder: "닉네임으로 검색",
                                    opacityValue: 1.0
                                )
                            }
                            
                            Spacer()
                            
                            NavigationLink(value: MainNavigationRoutes.number) {
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
                }
            }
            .navigationDestination(for: MainNavigationRoutes.self) { route in
                switch route {
                case .nickname:
                    UserSearchView()
                case .number:
                    NumberSearchView()
                }
            }
        }
    }
}
