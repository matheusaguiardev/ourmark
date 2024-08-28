//
//  ourmarketApp.swift
//  ourmarket
//
//  Created by Matheus Aguiar on 29/04/24.
//

import SwiftUI
import FirebaseCore

@main
struct ourmarketApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
    var body: some Scene {
        WindowGroup {
            LoginView()
        }
    }
}
