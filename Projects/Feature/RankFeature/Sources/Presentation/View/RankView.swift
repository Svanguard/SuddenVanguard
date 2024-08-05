//
//  RankView.swift
//  RankFeature
//
//  Created by 강치우 on 8/4/24.
//  Copyright © 2024 Svanguard. All rights reserved.
//

import DesignSystem
import SwiftUI

public struct RankView: View {
    public init() { }
    
    @State private var text: String = ""
    @State private var isEditing: Bool = false
    
    // MARK: 임시 데이터 배열
    private let users = [
        ("이창준", "2453454241"),
        ("강치우", "1231241352"),
        ("김희성", "1231241242"),
        ("최동호", "2453454241"),
        ("노주영", "1231241352"),
        ("김명현", "1231241242"),
        ("황민채", "2342352312"),
        ("이민영", "5634524343"),
        ("황성진", "3452342345"),
    ]
    
    // MARK: 필터링
    private var filteredUsers: [(String, String)] {
        if text.isEmpty {
            return users
        } else {
            return users.filter { $0.0.contains(text) || $0.1.contains(text) }
        }
    }
    
    public var body: some View {
        NavigationStack {
            if #available(iOS 17.0, *) {
                VStack {
                    List(filteredUsers, id: \.0) { user in
                        Section {
                            RankUserListCell(surfingID: user.0, surfingUsername: user.1)
                        }
                        .listSectionSeparator(.hidden, edges: .top)
                    }
                    .listStyle(.plain)
                    .searchable(text: $text, placement: .navigationBarDrawer(displayMode: .always), prompt: "검색")
                }
                .navigationTitle("실시간랭킹")
                // MARK: 이게 너무 쓰고싶은데 17버전에서만 지원해서 쩔수없이 버전 분기처리함 ㅠ.ㅠ
                .toolbarTitleDisplayMode(.inlineLarge)
            } else {
                VStack {
                    List(filteredUsers, id: \.0) { user in
                        Section {
                            RankUserListCell(surfingID: user.0, surfingUsername: user.1)
                        }
                        .listSectionSeparator(.hidden, edges: .top)
                    }
                    .listStyle(.plain)
                    .searchable(text: $text, placement: .navigationBarDrawer(displayMode: .always), prompt: "검색")
                }
                .navigationTitle("실시간랭킹")
                .navigationBarTitleDisplayMode(.large)
            }
        }
    }
}

#Preview {
    RankView()
}
