//
//  ResultView.swift
//  DesignSystem
//
//  Created by 최동호 on 9/5/24.
//  Copyright © 2024 Svanguard. All rights reserved.
//

import SwiftUI

public struct ResultView: View {
    let title: String
    let content: String
    let image: Config
    let showLink: Bool
    let linkURL: URL?
    
    @State private var showSafari = false
    
    public init(
        title: String,
        content: String,
        image: Config,
        showLink: Bool = false,
        linkURL: URL? = nil
    ) {
        self.title = title
        self.content = content
        self.image = image
        self.showLink = showLink
        self.linkURL = linkURL
    }
    
    public var body: some View {
        VStack(spacing: 15) {
            Spacer()
            
            Image(systemName: image.content)
                .font(.title)
                .foregroundStyle(image.foreground)
                .frame(width: 65, height: 65)
                .background(image.tint, in: .circle)
                .background {
                    Circle()
                        .stroke(.background, lineWidth: 8)
                }
            
            Text(title)
                .font(.title3.bold())
            
            Text(content)
                .font(.callout)
                .fontWeight(.medium)
                .multilineTextAlignment(.center)
                .lineLimit(2)
                .foregroundStyle(.gray)
                .padding(.vertical, 6)
            
            Spacer()
            
            // showLink가 true일 때만 버튼을 표시
            if showLink, let linkURL = linkURL {
                Button(action: {
                    showSafari = true
                }) {
                    Text("병영수첩으로 이동")
                        .font(.body)
                        .fontWeight(.semibold)
                        .frame(maxWidth: .infinity, maxHeight: 50)
                        .foregroundStyle(.primary)
                        .cornerRadius(8)
                        .overlay(
                            RoundedRectangle(cornerRadius: 6)
                                .stroke(Color.gray, lineWidth: 0.7)
                        )
                }
                .sheet(isPresented: $showSafari) {
                    SafariView(url: linkURL)
                }
                .padding(.bottom)
                .padding(.horizontal)
            }
        }
    }
    
    public struct Config {
        let content: String
        let tint: Color
        let foreground: Color
        
        public init(
            content: String,
            tint: Color,
            foreground: Color
        ) {
            self.content = content
            self.tint = tint
            self.foreground = foreground
        }
    }
}
