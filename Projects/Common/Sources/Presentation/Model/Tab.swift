//
//  Tab.swift
//  Common
//
//  Created by 강치우 on 9/15/24.
//  Copyright © 2024 Svanguard. All rights reserved.
//

import DesignSystem
import SwiftUI

public enum Tab: String {
    case main = "뱅가드"
    case rank = "실시간순위"
    case report = "제보하기"
    case setting = "설정"
    
    public var symbolImage: Image {
        switch self {
        case .main:
            return Image(uiImage: DesignSystemAsset.vanguard.image)
        case .rank:
            return Image(uiImage: DesignSystemAsset.flame.image)
        case .report:
            return Image(uiImage: DesignSystemAsset.mail.image)
        case .setting:
            return Image(systemName: "gearshape")
        }
    }
}
