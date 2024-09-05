//
//  NumberSearchView.swift
//  MainFeature
//
//  Created by 최동호 on 9/5/24.
//  Copyright © 2024 Svanguard. All rights reserved.
//

import DesignSystem
import SwiftUI

struct NumberSearchView: View {
    @StateObject var viewModel = NumberSearchViewModel()

    var body: some View {
        if #available(iOS 17.0, *) {
            NumberSearch
                .searchable(
                    text: $viewModel.searchQuery,
                    isPresented: $viewModel.isSearchFieldFocused,
                    placement: .navigationBarDrawer(displayMode: .always),
                    prompt: "병영번호 검색"
                )
        } else {
            NumberSearch
                .searchable(
                    text: $viewModel.searchQuery,
                    placement: .navigationBarDrawer(displayMode: .always),
                    prompt: "병영번호 검색"
                )
        }
    }
    
    @ViewBuilder
    private var NumberSearch: some View {
        VStack {
            if viewModel.isLoading {
                ProgressView()
            }
        }
        .navigationTitle("병영번호 검색")
        .navigationBarTitleDisplayMode(.inline)
    }
}
