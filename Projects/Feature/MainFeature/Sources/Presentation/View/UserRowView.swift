//
//  UserRowView.swift
//  MainFeature
//
//  Created by 강치우 on 8/20/24.
//  Copyright © 2024 Svanguard. All rights reserved.
//

import Kingfisher

import DesignSystem
import Common
import SwiftUI

struct UserRowView: View {
    let user: SearchUserData
    
    var body: some View {
        HStack {
            KFImage(URL(string: user.userImage))
                .placeholder { 
                    Image(uiImage: DesignSystemAsset.userimg.image)
                        .resizable()
                        .scaledToFill()
                        .foregroundStyle(.white)
                        .frame(width: 50, height: 50)
                        .clipShape(Circle())
                }
                .resizable()
                .scaledToFill()
                .frame(width: 50, height: 50)
                .clipShape(Circle())
            
            VStack(alignment: .leading, spacing: 8) {
                Text(user.userName)
                    .font(.headline)
                
                let formattedNexonSN = String(user.suddenNumber).replacingOccurrences(of: ",", with: "")
                Text("병영 번호: \(formattedNexonSN)")
                    .font(.subheadline)
                    .lineLimit(1)
                    .minimumScaleFactor(0.5)
            }
            .padding(.leading, 8)
        }
    }
}
