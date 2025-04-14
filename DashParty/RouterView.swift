//
//  RouterView.swift
//  DashParty
//
//  Created by Fernanda Auler on 11/04/25.
//

import SwiftUI

struct RouterView: View {
    @Binding var router:Router
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
        case .waitingRoom:
            WaitingView(router: $router, multipeerSession: multipeerSession)
        case .matchmaking:
            RoomView(router: $router, multipeerSession: multipeerSession)
        case .storyBoard:
            if multipeerSession.host {
                NarrativePassingView(router: $router)
            }
            else {
                EyesOnTheHub()
            }
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
    RouterView(router: .constant(.start))
}
