//
//  MainTabView.swift
//  ProjectDescriptionHelpers
//
//  Created by 최동호 on 8/3/24.
//

import MainFeature
import RankFeature
import ReportFeature
import SettingFeature

import SwiftUI

public struct MainTabView: View {
    public init() { }
    
    public var body: some View {
        TabView {
            MainView()
                .tabItem {
                    Label("전과자", systemImage: "person.slash")
                }
            
            RankView()
                .tabItem {
                    Label("실시간순위", systemImage: "trophy")
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
