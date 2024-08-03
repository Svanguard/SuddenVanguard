//
//  SampleView2.swift
//  MainTabFeature
//
//  Created by 강치우 on 8/3/24.
//  Copyright © 2024 Svanguard. All rights reserved.
//

import SwiftUI

struct SampleView2: View {
    var body: some View {
        NavigationStack {
            VStack {
                Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
            }
            .navigationTitle("제보하기")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

#Preview {
    SampleView2()
}
