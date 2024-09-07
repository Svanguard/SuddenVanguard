//
//  NoticeView.swift
//  SettingFeature
//
//  Created by 강치우 on 8/12/24.
//  Copyright © 2024 Svanguard. All rights reserved.
//

import SwiftUI

struct NoticeView: View {
    @State private var isExpanded = false

    var body: some View {
        List {
            Section {
                DisclosureGroup(isExpanded: $isExpanded) {
                    VStack(alignment: .leading, spacing: 8) {
                        Text("공식 디스코드 채널 안내")
                            .font(.body)
                            .foregroundStyle(.primary)
                        
                        Text("디스코드 채널을 통해 최신 정보와 업데이트 소식을 받아보세요.")
                            .font(.footnote)
                            .foregroundStyle(.gray)
                            .padding(.top, 4)
                        
                        Link("이동하기", destination: URL(string: "https://discord.gg/h3pGsGgNzD")!)
                                                    .font(.footnote)
                                                    .foregroundStyle(.blue)
                    }
                    .padding(.vertical, 8)
                } label: {
                    VStack(alignment: .leading, spacing: 8) {
                        Text("1.0.0")
                            .font(.caption)
                            .fontWeight(.medium)
                            .foregroundStyle(.gray)
                        
                        Text("공식 디스코드 채널 안내")
                            .font(.body)
                            .foregroundStyle(.primary)
                    }
                }
                .tint(.white)
            }
        }
        .listStyle(.plain)
        .navigationTitle("공지사항")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    NoticeView()
}
