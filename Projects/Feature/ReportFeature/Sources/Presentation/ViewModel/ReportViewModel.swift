//
//  ReportViewModel.swift
//  ReportFeature
//
//  Created by 강치우 on 8/11/24.
//  Copyright © 2024 Svanguard. All rights reserved.
//

import SwiftUI
import Combine

final class ReportViewModel: ObservableObject {
    @Published var expandedSections: Set<UUID> = []
    
    init() { }
    
    func toggleSection(_ id: UUID) {
        if expandedSections.contains(id) {
            expandedSections.remove(id)
        } else {
            expandedSections.insert(id)
        }
    }
    
    func isSectionExpanded(_ id: UUID) -> Bool {
        return expandedSections.contains(id)
    }
}
