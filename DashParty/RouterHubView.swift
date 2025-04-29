//
//  RouterView.swift
//  DashParty
//
//  Created by Fernanda Auler on 11/04/25.
//

import SwiftUI

struct RouterHubView: View {
    @Binding var router:Router
    var multipeerSession : MPCSession = MPCSessionManager.shared
    let user = HUBPhoneManager.instance.user
    @State var matchManager = HUBPhoneManager.instance.matchManager
    var body: some View {
        switch router {
        case .chooseCharacter:
            MatchmakingHubView(router: $router, multipeerSession: multipeerSession)
        case .start:
            InitialView()
        case .options:
            InitialView()
        case .play:
            InitialView()
        case .createRoom:
            InitialView()
        case .createName:
            InitialView()
        case .airplayInstructions:
            InitialView()
        case .chooseRoom:
            InitialView()
        case .waitingRoom:
            InitialView()
        case .matchmaking:
            MatchmakingHubView(router: $router, multipeerSession: multipeerSession)
        case .storyBoard:
            NarrativeView()
        case .tutorial:
            TutorialHubView(router: $router)
        case .game:
            MatchGridView(router: $router, count: multipeerSession.mcSession.connectedPeers.count, user: user, matchManager: matchManager)
        case .victoryStory:
            Text("Victory")
        case .ranking:
            YouWonView(router: $router)
        }
    }
}

#Preview {
    RouterView(router: .constant(.start))
}
