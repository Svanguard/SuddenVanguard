//
//  SettingView.swift
//  MainTabFeature
//
//  Created by 강치우 on 8/3/24.
//  Copyright © 2024 Svanguard. All rights reserved.
//

import SwiftUI

public struct SettingView: View {
    public init() { }
    
    public var body: some View {
        NavigationStack {
            VStack {
                List {
                    Section {
                        NavigationLink {
                            
                        } label: {
                            Text("공지사항")
                        }
                    } header: {
                        Text("알림")
                    }
                    
                    Section {
                        NavigationLink {
                            
                        } label: {
                            Text("서비스 이용약관")
                        }
                        
                        HStack {
                            Text("버전 정보")
                            
                            Spacer()
                            
                            Text("1.0.0 (최신버전)")
                                .foregroundStyle(.gray)
                                .font(.footnote)
                        }
                    } header: {
                        Text("서든뱅가드 정보")
                    }
                    
                    Section {
                        NavigationLink {
                            
                        } label: {
                            Text("서비스 문의")
                        }
                    } header: {
                        Text("고객지원")
                    }
                }
                .listStyle(.grouped)
            }
            .navigationTitle("설정")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

#Preview {
    SettingView()
}
