//
//  SampleView.swift
//  MainTabFeature
//
//  Created by 강치우 on 8/4/24.
//  Copyright © 2024 Svanguard. All rights reserved.
//

import SwiftUI

struct SampleView: View {
    var body: some View {
        NavigationStack {
            VStack {
                Text("Hello, World!")
            }
            .navigationTitle("핵의심")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

#Preview {
    SampleView()
}
