//
//  SampleView3.swift
//  MainTabFeature
//
//  Created by 강치우 on 8/3/24.
//  Copyright © 2024 Svanguard. All rights reserved.
//

import SwiftUI

public struct SampleView3: View {
    public init() { }
    
    public var body: some View {
        NavigationStack {
            VStack {
                Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
            }
            .navigationTitle("설정")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

#Preview {
    SampleView3()
}
