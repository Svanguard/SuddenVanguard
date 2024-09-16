//
//  ReviewCounter.swift
//  Common
//
//  Created by 강치우 on 9/14/24.
//  Copyright © 2024 Svanguard. All rights reserved.
//

import SwiftUI
import StoreKit

public struct ReviewCounter: ViewModifier {
    @AppStorage("reviewCounter") private var reviewCounter = 0

    public func body(content: Content) -> some View {
        content
            .onAppear {
                reviewCounter += 1
                print("reviewCounter", reviewCounter)
            }
            .onDisappear {
                if reviewCounter > 30 {
                    reviewCounter = 0
                    DispatchQueue.main.async {
                        if let scene = UIApplication.shared.connectedScenes
                                .first(where: { $0.activationState == .foregroundActive })
                                as? UIWindowScene {
                            SKStoreReviewController.requestReview(in: scene)
                        }
                    }
                }
            }
    }
}

extension View {
    public func reviewCounter() -> some View {
        modifier(ReviewCounter())
    }
}
