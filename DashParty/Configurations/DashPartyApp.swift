//
//  DashPartyApp.swift
//  DashParty
//
//  Created by Luana Bueno on 11/03/25.
//

import SwiftUI

@main
struct DashPartyApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    
    var body: some Scene {
        WindowGroup {
            ContentView()
            CharacterView()
        }
    }
}
