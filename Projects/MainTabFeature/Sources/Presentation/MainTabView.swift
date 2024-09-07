//
//  MainTabView.swift
//  ProjectDescriptionHelpers
//
//  Created by 최동호 on 8/3/24.
//

import DesignSystem
import MainFeature
import RankFeature
import ReportFeature
import SettingFeature

import SwiftUI

public struct MainTabView: View {
    public init() {
        setupTabBarAppearance()
    }
    
    public var body: some View {
        TabView {
            MainView()
                .tabItem {
                    VStack {
                        Image(uiImage: DesignSystemAsset.vanguard.image)
                            .resizable()
                            .scaledToFit()
                        Text("뱅가드")
                            .font(.body)
                    }
                }
            
            RankView()
                .tabItem {
                    VStack {
                        Image(uiImage: DesignSystemAsset.flame.image)
                            .resizable()
                            .scaledToFit()
                        Text("실시간순위")
                            .font(.body)
                    }
                }
            
            ReportView()
                .tabItem {
                    VStack {
                        Image(uiImage: DesignSystemAsset.mail.image)
                            .resizable()
                            .scaledToFit()
                        Text("제보하기")
                            .font(.body)
                    }
                }
            
            SettingView()
                .tabItem {
                    VStack {
                        Image(systemName: "gearshape")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 18, height: 18)
                        Text("설정")
                            .font(.body)
                    }
                }
        }
        .tint(.primary)
    }
    
    private func setupTabBarAppearance() {
        let appearance = UITabBarAppearance()
        appearance.configureWithDefaultBackground()
        
        appearance.shadowColor = UIColor.darkGray
        
        UITabBar.appearance().standardAppearance = appearance
        UITabBar.appearance().scrollEdgeAppearance = appearance
    }
}
