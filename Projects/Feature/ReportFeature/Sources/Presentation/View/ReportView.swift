//
//  ReportView.swift
//  ReportFeature
//
//  Created by 강치우 on 8/3/24.
//  Copyright © 2024 Svanguard. All rights reserved.
//

import DesignSystem
import SwiftUI

public struct ReportView: View {
    public init() { }
    
    @State private var expandedSections: Set<UUID> = []
    
    private var items = ReportModel.items
    private var image = exampleImage.item
    
    public var body: some View {
        NavigationStack {
            VStack {
                TabView {
                    ForEach(image) { exampleImage in
                        Image(uiImage: exampleImage.imageName)
                            .resizable()
                            .cornerRadius(10)
                            .scaledToFit()
                            .clipped()
                            .overlay {
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(DesignSystemAsset.searchBorderColor.swiftUIColor, lineWidth: 1.5)
                            }
                            .padding(.horizontal, 3)
                            
                    }
                }
                .tabViewStyle(.page(indexDisplayMode: .automatic))
                .frame(height: 210)
                .padding([.top, .horizontal])
                
                ScrollViewReader { scrollViewProxy in
                    List {
                        Section {
                            ForEach(items) { item in
                                DisclosureGroup(
                                    isExpanded: Binding(
                                        get: { expandedSections.contains(item.id) },
                                        set: { isExpanded in
                                            if isExpanded {
                                                expandedSections.insert(item.id)
                                                DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                                                    withAnimation {
                                                        scrollViewProxy.scrollTo(item.id, anchor: .top)
                                                    }
                                                }
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
                                        HStack {
                                            Image(systemName: "questionmark")
                                            
                                            Text(item.title)
                                                .fontWeight(.medium)
                                        }
                                    }
                                )
                                .id(item.id)
                            }
                        } header: {
                            Text("자주 묻는 질문 (FAQ)")
                        }
                        .listSectionSeparator(.hidden)
                    }
                    .tint(.primary)
                    .listStyle(.grouped)
                    .navigationTitle("제보하기")
                    .navigationBarTitleDisplayMode(.inline)
                    .navigationBarItems(trailing: Button {
                        
                    } label: {
                        Text("제보")
                            .foregroundStyle(.red)
                    })
                }
            }
        }
    }
}

#Preview {
    ReportView()
}
