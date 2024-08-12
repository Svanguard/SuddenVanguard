//
//  ReportViewModel.swift
//  ReportFeature
//
//  Created by 강치우 on 8/11/24.
//  Copyright © 2024 Svanguard. All rights reserved.
//

import Common
import Combine
import MessageUI
import SwiftUI

final class ReportViewModel: ObservableObject {
    @Published var expandedSections: Set<UUID> = []
    @Published var items: [ReportModel] = []
    @Published var images: [ScreenShotImage] = []
    @Published var showMailView = false
    @Published var showMailErrorAlert = false
    @Published var mailContent = MailContent.defaultMailContent()

    init() {
        loadItems()
        loadImages()
    }

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

    func loadItems() {
        items = ReportModel.items
    }

    func loadImages() {
        images = ScreenShotImage.item
    }
    
    func resetExpandedSections() {
        expandedSections.removeAll()
    }

    func mailButtonTapped() {
        if MFMailComposeViewController.canSendMail() {
            HapticFeedbackManager.shared.triggerHapticFeedback()
            showMailView = true
        } else {
            showMailErrorAlert = true
        }
    }
}
