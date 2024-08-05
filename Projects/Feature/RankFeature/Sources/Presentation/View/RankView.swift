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
    
    // 임시 데이터 배열
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
    
    public var body: some View {
        NavigationStack {
            VStack {
                HStack {
                    Image(systemName: "magnifyingglass")
                        .foregroundColor(.primary)
                    
                    TextField("검색", text: $text)
                        .foregroundColor(.primary)
                        .tint(.primary)
                        .submitLabel(.search)
                        .onTapGesture {
                            withAnimation {
                                isEditing = true
                            }
                        }
                        .overlay {
                            HStack {
                                Spacer()
                                
                                if isEditing && !text.isEmpty {
                                    Button(action: {
                                        text = ""
                                    }) {
                                        Image(systemName: "xmark.circle.fill")
                                            .foregroundColor(Color.gray)
                                            .frame(width: 35, height: 35)
                                    }
                                    .padding(.trailing, 5)
                                }
                            }
                        }
                }
                .padding(10)
                .background(Color(.systemGray6))
                .cornerRadius(12)
                .padding(.top, 20)
                .padding(.horizontal)
                
                List(users, id: \.0) { user in
                    RankUserListCell(surfingID: user.0, surfingUsername: user.1)
                }
                .listStyle(.plain)
                .padding(.top, 8)
            }
            .navigationTitle("실시간랭킹")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

#Preview {
    RankView()
}
