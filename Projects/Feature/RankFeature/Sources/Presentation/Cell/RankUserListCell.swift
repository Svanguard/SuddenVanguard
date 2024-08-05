//
//  RankUserListCell.swift
//  RankFeature
//
//  Created by 강치우 on 8/5/24.
//  Copyright © 2024 Svanguard. All rights reserved.
//

import SwiftUI

public struct RankUserListCell: View {
    let surfingID: String
    let surfingUsername: String
    
    public var body: some View {
        VStack {
            HStack(alignment: .top) {
                Circle()
                    .frame(width: 44, height: 44)
                
                VStack(alignment: .leading, spacing: 8) {
                    Text(surfingID)
                        .font(.system(.subheadline, weight: .semibold))
                    
                    Text(surfingUsername)
                        .font(.system(.footnote))
                        .foregroundStyle(Color(.systemGray))
                    
                    Text("검색 횟수 : 12314")
                        .font(.caption)
                        .fontWeight(.semibold)
                        .padding(.top, 6)
                }
                .padding(.horizontal, 4)
                
                Spacer()
                
                Button {
                    
                } label: {
                    Text("병영 수첩")
                        .font(.subheadline)
                        .fontWeight(.semibold)
                        .padding(.horizontal, 12)
                        .padding(.vertical, 6)
                        .foregroundStyle(.primary)
                        .cornerRadius(8)
                        .overlay(
                            RoundedRectangle(cornerRadius: 6)
                                .stroke(Color.gray, lineWidth: 0.7)
                        )
                }
                .padding(5)
            }
        }
    }
}

#Preview {
    RankView()
}
