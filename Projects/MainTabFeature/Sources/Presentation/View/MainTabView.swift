//
//  MainTabView.swift
//  ProjectDescriptionHelpers
//
//  Created by 최동호 on 8/3/24.
//

import Common
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
    
    @State private var selection: TabType = .main
    
    public var body: some View {
        TabView(selection: binding) {
            MainView()
                .tag(TabType.main)
                .tabItem {
                    VStack {
                        Image(uiImage: DesignSystemAsset.vanguard.image)
                            .resizable()
                            .scaledToFit()
                        Text(TabType.main.rawValue)
                            .font(.body)
                    }
                }
            
            RankView()
                .tag(TabType.rank)
                .tabItem {
                    VStack {
                        Image(uiImage: DesignSystemAsset.flame.image)
                            .resizable()
                            .scaledToFit()
                        Text(TabType.rank.rawValue)
                            .font(.body)
                    }
                }
            
            ReportView()
                .tag(TabType.report)
                .tabItem {
                    VStack {
                        Image(uiImage: DesignSystemAsset.mail.image)
                            .resizable()
                            .scaledToFit()
                        Text(TabType.report.rawValue)
                            .font(.body)
                    }
                }
            
            SettingView()
                .tag(TabType.setting)
                .tabItem {
                    VStack {
                        Image(systemName: "gearshape")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 18, height: 18)
                        Text(TabType.setting.rawValue)
                            .font(.body)
                    }
                }
        }
        .tint(.primary)
    }
    
    private var binding: Binding<TabType> {
        return .init {
            return selection
        } set: { selection in
            if selection == self.selection {
                NotificationCenter.default.postTabViewItemDidChange(selection)
            }
            self.selection = selection
        }
    }
    
    private func setupTabBarAppearance() {
        let appearance = UITabBarAppearance()
        appearance.configureWithDefaultBackground()
        appearance.shadowColor = UIColor.darkGray
        
        UITabBar.appearance().standardAppearance = appearance
        UITabBar.appearance().scrollEdgeAppearance = appearance
    }
}
