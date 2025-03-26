//
//  WhisperBoxApp.swift
//  WhisperBox
//
//  Created by kirby on 3/25/25.
//

import SwiftUI

@main
struct WhisperBoxApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    var body: some Scene {
        WindowGroup {
            NavigationStack {
                StartView()
            }
            .toolbar(.hidden, for: .navigationBar) // 👈 전역처럼 적용!
        }
    }
}
