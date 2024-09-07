//
//  SuddenVanguardApp.swift
//  ATeen
//
//  Created by 최동호 on 5/15/24.
//

import MainTabFeature
import SwiftUI

@main
struct SuddenVanguardApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate

    var body: some Scene {
        WindowGroup {
            MainTabView()
        }
    }
}
