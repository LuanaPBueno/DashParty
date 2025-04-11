//
//  RouterView.swift
//  DashParty
//
//  Created by Fernanda Auler on 11/04/25.
//

import SwiftUI

struct RouterView: View {
    @State var router:Router = .start
    var multipeerSession : MPCSession = MPCSessionManager.shared
    var body: some View {
        switch router {
        case .start:
            ContentView(router: $router)
        case .options:
            OptionsView()
        case .play:
            HostOrPlayerView(router: $router)
        case .createRoom:
            Text("CreateRoom")
        case .createName:
            Text("CreateName")
        case .airplayInstructions:
            ReadyView(router: $router)
        case .chooseRoom:
            RoomListView(router: $router, multipeerSession: multipeerSession)
        case .matchmaking:
            RoomView(router: $router, multipeerSession: multipeerSession)
        case .storyBoard:
            NarrativePassingView(router: $router)
        case .tutorial:
            TutorialPassingView(router: $router, multipeerSession: multipeerSession)
        case .game:
            matchPhoneView()
        case .victoryStory:
            Text("Victory")
        case .ranking:
            YouWonView()
        }
    }
}

#Preview {
    RouterView()
}
