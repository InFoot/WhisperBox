//
//  WhisperBoxApp.swift
//  WhisperBox
//
//  Created by kirby on 3/25/25.
//

import SwiftUI
import Combine

@main
struct WhisperBoxApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
    @StateObject var coordinator: Coordinator = Coordinator()
    var body: some Scene {
        WindowGroup {
            NavigationStack(path: $coordinator.route) {
                MainView()
                    .environmentObject(coordinator)
                    .navigationDestination(for: ViewType.self) { value in
                        switch value {
                        case .lockedLetter:
                            LockedLetterView()
                                .toolbar(.hidden, for: .navigationBar)
                        case .main:
                            MainView()
                                .toolbar(.hidden, for: .navigationBar)
                        case .writeMessage:
                            WriteMessageView()
                                .toolbar(.hidden, for: .navigationBar)
                        }
                    }
            }
            .toolbar(.hidden, for: .navigationBar) // 👈 전역처럼 적용!
        }
    }
}
