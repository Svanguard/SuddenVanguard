//
//  SettingView.swift
//  SettingFeature
//
//  Created by 강치우 on 8/3/24.
//  Copyright © 2024 Svanguard. All rights reserved.
//

import Common
import DesignSystem
import SwiftUI

public struct SettingView: View {
    public init() { }
    
    @State private var path = NavigationPath()
    
    public var body: some View {
        NavigationStack(path: $path) {
            TabViewItemWrapperView(path: $path, selection: .setting) {
                VStack {
                    List {
                        Section {
                            NavigationLink(value: SettingNavigationRoute.notice) {
                                Text("공지사항")
                            }
                        } header: {
                            Text("알림")
                        }
                        
                        Section {
                            NavigationLink(value: SettingNavigationRoute.webView(url: URL(string: "https://kangciu.notion.site/5db62cd34a5c4ea18f4214707839efc0?pvs=4")!, title: "이용약관")) {
                                Text("서든뱅가드 이용약관")
                            }
                            
                            NavigationLink(value: SettingNavigationRoute.webView(url: URL(string: "https://kangciu.notion.site/e1eb4ff3f8fd40babb62da2c7cd1bc80?pvs=4")!, title: "개인정보 처리 방침")) {
                                Text("서든뱅가드 개인정보 처리 방침")
                            }
                            
                            HStack {
                                Text("버전 정보")
                                
                                Spacer()
                                
                                Text("1.0.3 (최신버전)")
                                    .foregroundStyle(.gray)
                                    .font(.footnote)
                            }
                        } header: {
                            Text("서든뱅가드 정보")
                        }
                        
                        Section {
                            HStack {
                                Button {
                                    let appID = "6670616799"
                                    let urlString = "https://apps.apple.com/app/id\(appID)?action=write-review"
                                    if let url = URL(string: urlString) {
                                        UIApplication.shared.open(url)
                                    }
                                } label: {
                                    Text("평가하기")
                                }
                                
                                Spacer()
                                
                                Image(systemName: "chevron.right")
                                    .font(.footnote)
                                    .fontWeight(.medium)
                                    .foregroundStyle(DesignSystemAsset.chevronColor.swiftUIColor)
                            }
                        } header: {
                            Text("고객지원")
                        }
                    }
                    .listStyle(.grouped)
                }
                .navigationTitle("설정")
                .navigationBarTitleDisplayMode(.inline)
                .navigationDestination(for: SettingNavigationRoute.self) { route in
                    switch route {
                    case .notice:
                        NoticeView()
                    case .webView(let url, let title):
                        WebViewScreen(url: url, title: title)
                    }
                }
            }
        }
    }
}

struct WebViewScreen: View {
    let url: URL
    let title: String
    
    var body: some View {
        WebView(url: url)
            .navigationTitle(title)
            .navigationBarTitleDisplayMode(.inline)
    }
}
