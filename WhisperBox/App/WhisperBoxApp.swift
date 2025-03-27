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
                VStack {
                    
                }
                    .environmentObject(coordinator)
                    .navigationDestination(for: ViewType.self) { value in
                        switch value {
                        case .inputNickname:
                            InputNicknameView()
                                .environmentObject(coordinator)
                                .toolbar(.hidden, for: .navigationBar)
                        case .welcomeUser:
                            WelcomeUserView()
                                .environmentObject(coordinator)
                                .toolbar(.hidden, for: .navigationBar)
                        case .lockedLetter:
                            LockedLetterView()
                                .environmentObject(coordinator)
                                .toolbar(.hidden, for: .navigationBar)
                        case .main:
                            MainView()
                                .environmentObject(coordinator)
                                .toolbar(.hidden, for: .navigationBar)
                        case .writeMessage(let user):
                            WriteMessageView(user)
                                .environmentObject(coordinator)
                                //.toolbar(.hidden, for: .navigationBar)
                        case .searchReceiver:
                            UserListView(onUserSelected: { user in
                                coordinator.push(.writeMessage(user))
                            })
                            .environmentObject(coordinator)
                        }
                    }
            }
            .toolbar(.hidden, for: .navigationBar) // 👈 전역처럼 적용!
        }
    }
}
