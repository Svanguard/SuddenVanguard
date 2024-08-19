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
    @Binding var text: String
    @Binding var isEditing: Bool
    var onSubmit: () -> Void
    
    var body: some View {
        HStack {
            Image(systemName: "magnifyingglass")
                .foregroundColor(.white)
            
            TextField("닉네임을 입력하세요.", text: $text)
                .foregroundColor(.white)
                .tint(.white)
                .submitLabel(.search)
                .onTapGesture {
                    withAnimation {
                        isEditing = true
                    }
                }
                .onSubmit {
                    onSubmit()
                }
                .overlay {
                    if isEditing && !text.isEmpty {
                        HStack {
                            Spacer()
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
        .padding()
        .border(DesignSystemAsset.searchBorderColor.swiftUIColor)
        .background(DesignSystemAsset.searchColor.swiftUIColor)
        .padding(.top, 20)
    }
}
