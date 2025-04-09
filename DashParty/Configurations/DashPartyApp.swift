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
    
//    init() {
//        if let fontURL = Bundle.main.url(forResource: "TorukscRegular-z8MA1", withExtension: "ttf") {
//            CTFontManagerRegisterFontsForURL(fontURL as CFURL, .process, nil)
//        }
//    }
    var body: some Scene {
        WindowGroup {
            

                        ContentView()
        }
    }
}

