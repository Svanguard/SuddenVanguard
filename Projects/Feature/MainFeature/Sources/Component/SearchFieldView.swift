//
//  SearchFieldView.swift
//  MainFeature
//
//  Created by 강치우 on 8/12/24.
//  Copyright © 2024 Svanguard. All rights reserved.
//

import Common
import DesignSystem
import SwiftUI

struct SearchFieldView: View {
    var body: some View {
        HStack {
            Image(systemName: "magnifyingglass")
                .foregroundStyle(.white)
            
            Text("닉네임으로 검색하기")
                .foregroundStyle(.gray)
            
            Spacer()
        }
        .frame(width: UIScreen.main.bounds.width / 1.2)
        .padding()
        .border(DesignSystemAsset.searchBorderColor.swiftUIColor)
        .background(DesignSystemAsset.searchColor.swiftUIColor)
        .padding(.top, 20)
    }
}
