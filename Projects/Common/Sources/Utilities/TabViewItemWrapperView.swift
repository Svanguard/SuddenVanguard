//
//  TabViewItemWrapperView.swift
//  Common
//
//  Created by 강치우 on 9/15/24.
//  Copyright © 2024 Svanguard. All rights reserved.
//

import SwiftUI

public struct TabViewItemWrapperView<C: View>: View {
    @Binding var path: NavigationPath
    
    let selection: Tab
    var view: () -> C
    
    @Environment(\.refresh) var refreshAction
    
    public init(path: Binding<NavigationPath>, selection: Tab, @ViewBuilder view: @escaping () -> C) {
        self._path = path
        self.selection = selection
        self.view = view
    }
    
    public var body: some View {
        ScrollViewReader { proxy in
            view()
                .onReceive(NotificationCenter.default.publisher(for: .tabViewItemDidChange)) { notification in
                    if let selection = notification.object as? Tab, self.selection == selection {
                        if !(path.isEmpty) {
                            path = .init()
                        }
                    }
                }
        }
    }
}

extension NotificationCenter {
    
    public func postTabViewItemDidChange(_ selection: Tab) {
        post(name: .tabViewItemDidChange, object: selection)
    }
}

extension NSNotification.Name {
    
    public static let tabViewItemDidChange = NSNotification.Name("tabViewItemDidChange")
}
