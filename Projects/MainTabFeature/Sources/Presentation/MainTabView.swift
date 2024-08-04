//
//  MainTabView.swift
//  ProjectDescriptionHelpers
//
//  Created by 최동호 on 8/3/24.
//

import MainFeature
import NoteFeature
import ReportFeature
import SettingFeature

import SwiftUI

public struct MainTabView: View {
    // MARK: 네비게이션, 탭바 디폴트 색상
    public init() {
        let appearance = UINavigationBarAppearance()
        appearance.configureWithDefaultBackground()
        UINavigationBar.appearance().standardAppearance = appearance
        UINavigationBar.appearance().scrollEdgeAppearance = appearance
        
        let tabBarAppearance = UITabBarAppearance()
        tabBarAppearance.configureWithDefaultBackground()
        UITabBar.appearance().standardAppearance = tabBarAppearance
        UITabBar.appearance().scrollEdgeAppearance = tabBarAppearance
    }
    
    public var body: some View {
        TabView {
            MainView()
                .tabItem {
                    Label("전과자", systemImage: "person.slash")
                }
            
            SampleView()
                .tabItem {
                    Label("핵의심", systemImage: "magnifyingglass")
                }
            
            ReportView()
                .tabItem {
                    Label("제보하기", systemImage: "light.beacon.max")
                }
            
            SettingView()
                .tabItem {
                    Label("설정", systemImage: "gearshape")
                }
        }
        .tint(.primary)
    }
}

#Preview {
    MainTabView()
}
