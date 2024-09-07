//
//  EmptyStateView.swift
//  MainFeature
//
//  Created by 강치우 on 8/20/24.
//  Copyright © 2024 Svanguard. All rights reserved.
//

import SwiftUI

struct EmptyStateView: View {
    let searchQuery: String
    let searchHistory: [String]
    let onTap: (String) -> Void
    let onDelete: (IndexSet) -> Void
    
    var body: some View {
        List {
            ForEach(searchHistory, id: \.self) { history in
                HStack {
                    Image(systemName: "magnifyingglass.circle.fill")
                        .foregroundColor(.gray)
                        .font(.title3)
                    
                    Text(history)
                        .padding(.leading, 4)
                        .font(.body)
                    
                    Spacer()
                    
                    Text(formattedDate(for: Date()))
                        .font(.subheadline)
                        .foregroundColor(.gray)
                }
                .contentShape(Rectangle())
                .onTapGesture {
                    onTap(history)
                }
            }
            .onDelete(perform: onDelete)
        }
        .listStyle(.plain)
    }
    
    private func formattedDate(for date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM. dd."
        return dateFormatter.string(from: date)
    }
}
