//
//  HapticFeedbackManager.swift
//  Common
//
//  Created by 강치우 on 8/12/24.
//  Copyright © 2024 Svanguard. All rights reserved.
//

import UIKit

public final class HapticFeedbackManager {
    
    public static let shared = HapticFeedbackManager()

    public let generator = UIImpactFeedbackGenerator(style: .medium)
    
    public init() {
        generator.prepare()
    }
    
    public func triggerHapticFeedback() {
        generator.impactOccurred()
    }
}
