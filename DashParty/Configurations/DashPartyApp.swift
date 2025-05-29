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
    @State var audioManager = AudioManager()
    @State var manager = GameInformation.instance
    #if os(tvOS)
    @State var tvRouter = RouterTV.logo
    #endif

    var body: some Scene {
        WindowGroup {
            //            @Bindable var manager = HUBPhoneManager.instance
            #if !os(tvOS)
            RouterView(router: $manager.router)
            #else
            RouterTVView(router: $tvRouter)
                .environmentObject(audioManager)
                .overlay(alignment: .top) {
                    Text("\(tvRouter)")
                        .monospaced()
                }
            #endif
        }
    }
}



