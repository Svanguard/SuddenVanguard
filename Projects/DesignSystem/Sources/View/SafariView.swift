//
//  SafariView.swift
//  DesignSystem
//
//  Created by 강치우 on 9/16/24.
//  Copyright © 2024 Svanguard. All rights reserved.
//

import SafariServices
import SwiftUI

public struct SafariView: UIViewControllerRepresentable {
    public let url: URL

    public init(url: URL) {
        self.url = url
    }

    public func makeUIViewController(context: UIViewControllerRepresentableContext<SafariView>) -> SFSafariViewController {
        return SFSafariViewController(url: url)
    }

    public func updateUIViewController(_ uiViewController: SFSafariViewController, context: UIViewControllerRepresentableContext<SafariView>) {}
}
