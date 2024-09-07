//
//  RankUserListCell.swift
//  RankFeature
//
//  Created by 강치우 on 8/5/24.
//  Copyright © 2024 Svanguard. All rights reserved.
//


import Common
import DesignSystem
import SafariServices
import SwiftUI
import Kingfisher

public struct RankUserListCell: View {
    let user: RankUser
    
    @State private var showSafari = false
    
    public var body: some View {
        VStack {
            HStack(alignment: .top) {
                KFImage(URL(string: user.userImage))
                    .placeholder {
                        Image(uiImage: DesignSystemAsset.userimg.image)
                            .resizable()
                            .scaledToFill()
                            .frame(width: 50, height: 50)
                            .clipShape(Circle())
                    }
                    .resizable()
                    .scaledToFill()
                    .frame(width: 44, height: 44)
                    .clipShape(Circle())
                
                VStack(alignment: .leading, spacing: 8) {
                    Text(user.username)
                        .font(.system(.subheadline, weight: .semibold))
                    
                    Text(String(user.suddenNumber))
                        .font(.system(.footnote))
                        .foregroundStyle(Color(.systemGray))
                    
                    Text("검색 횟수: \(user.count) 번")
                        .font(.caption)
                        .fontWeight(.semibold)
                        .padding(.top, 6)
                }
                .padding(.horizontal, 4)
                
                Spacer()
                
                Button {
                    HapticFeedbackManager.shared.triggerHapticFeedback()
                    showSafari = true
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
                .contentShape(Rectangle())
                .onTapGesture {
                    HapticFeedbackManager.shared.triggerHapticFeedback()
                    showSafari = true
                }
                .simultaneousGesture(TapGesture().onEnded { })
                .sheet(isPresented: $showSafari) {
                    SafariView(url: URL(string: "https://barracks.sa.nexon.com/\(user.suddenNumber)/match")!)
                }
            }
        }
        .contentShape(Rectangle())
    }
}

struct SafariView: UIViewControllerRepresentable {
    let url: URL

    func makeUIViewController(context: UIViewControllerRepresentableContext<SafariView>) -> SFSafariViewController {
        return SFSafariViewController(url: url)
    }

    func updateUIViewController(_ uiViewController: SFSafariViewController, context: UIViewControllerRepresentableContext<SafariView>) {}
}
