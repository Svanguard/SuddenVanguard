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
    private let placeHolder: String
    private let opacityValue: CGFloat
    
    init(
        placeHolder: String,
        opacityValue: CGFloat
    ) {
        self.placeHolder = placeHolder
        self.opacityValue = opacityValue
    }
    
    var body: some View {
        HStack {
            Image(systemName: "magnifyingglass")
                .foregroundStyle(.white)
            
            Text(placeHolder)
                .foregroundStyle(.gray)
            
            Spacer()
        }
        .foregroundStyle(.gray)
        .frame(width: UIScreen.main.bounds.width * 0.37)
        .padding()
        .border(DesignSystemAsset.searchBorderColor.swiftUIColor)
        .background(DesignSystemAsset.searchColor.swiftUIColor.opacity(opacityValue))
        .padding(.top, 20)
    }
}
