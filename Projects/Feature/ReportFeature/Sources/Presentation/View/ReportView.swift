//
//  ReportView.swift
//  MainTabFeature
//
//  Created by 강치우 on 8/3/24.
//  Copyright © 2024 Svanguard. All rights reserved.
//

import SwiftUI

public struct ReportView: View {
    public init() { }
    
    @State private var expandedSections: Set<UUID> = []
    
    private var items = ReportModel.items
    
    public var body: some View {
        NavigationStack {
            List {
                Section {
                    ForEach(items) { item in
                        DisclosureGroup(
                            isExpanded: Binding(
                                get: { expandedSections.contains(item.id) },
                                set: { isExpanded in
                                    if isExpanded {
                                        expandedSections.insert(item.id)
                                    } else {
                                        expandedSections.remove(item.id)
                                    }
                                }
                            ),
                            content: {
                                Text(item.subtitle)
                                    .font(.subheadline)
                            },
                            label: {
                                Text(item.title)
                            }
                        )
                    }
                } header: {
                    Text("자주 묻는 질문 (FAQ)")
                }
                .listSectionSeparator(.hidden)
            }
            .tint(.primary)
            .listStyle(.inset)
            .navigationTitle("FAQ")
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarItems(trailing: Button {
                
            } label: {
                Text("제보하기")
                    .foregroundStyle(.red)
            })
        }
    }
}

#Preview {
    ReportView()
}