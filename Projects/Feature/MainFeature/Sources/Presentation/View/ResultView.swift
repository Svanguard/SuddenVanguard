//
//  ResultView.swift
//  MainFeature
//
//  Created by 강치우 on 8/20/24.
//  Copyright © 2024 Svanguard. All rights reserved.
//

import SwiftUI

struct ResultView: View {
    let title: String
    let content: String
    let image: Config
    
    var body: some View {
        VStack(spacing: 15) {
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
                .multilineTextAlignment(.center)
                .lineLimit(2)
                .foregroundStyle(.gray)
                .padding(.vertical, 6)
        }
        .padding([.horizontal, .bottom], 15)
        .background {
            RoundedRectangle(cornerRadius: 12)
                .fill(.background)
                .padding(.top, 30)
        }
        .shadow(color: .black.opacity(0.12), radius: 8)
        .padding(.horizontal, 15)
    }
    
    struct Config {
        let content: String
        let tint: Color
        let foreground: Color
    }
}
