//
//  RankView.swift
//  RankFeature
//
//  Created by 강치우 on 8/4/24.
//  Copyright © 2024 Svanguard. All rights reserved.
//

import SwiftUI

public struct RankView: View {
    public init() { }
    
    public var body: some View {
        NavigationStack {
            VStack {
                Text("Hello, World!")
            }
            .navigationTitle("실시간랭킹")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

#Preview {
    RankView()
}
