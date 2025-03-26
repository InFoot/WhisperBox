//
//  AppDelegate.swift
//  WhisperBox
//
//  Created by 한건희 on 3/25/25.
//

import SwiftUI
import FirebaseCore

class AppDelegate: UIResponder, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        FirebaseApp.configure()
        return true
    }
}
