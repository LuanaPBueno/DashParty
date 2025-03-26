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
    
    init() {
            let cfURL = Bundle.main.url(forResource: "Prompt-Regular", withExtension: "ttf")! as CFURL
            CTFontManagerRegisterFontsForURL(cfURL, CTFontManagerScope.process, nil)
        }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}

