//
//  WhisperBoxApp.swift
//  WhisperBox
//
//  Created by kirby on 3/25/25.
//

import SwiftUI

@main
struct WhisperBoxApp: App {
    var body: some Scene {
        WindowGroup {
            NavigationStack {
                InputNicknameView()
            }
            .toolbar(.hidden, for: .navigationBar) // 👈 전역처럼 적용!
        }
    }
}
