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
    let user = GameInformation.instance.user
    @State var matchManager = GameInformation.instance.matchManager
    var body: some View {
        GeometryReader { proxy in
            ZStack {
                switch router {
                case .chooseCharacter:
                    MatchmakingHubView(router: $router, multipeerSession: multipeerSession, size: proxy.size)
                case .start:
                    MoonDashLogoHubView()
                case .options:
                    MoonDashLogoHubView()
                case .play:
                    MoonDashLogoHubView()
                case .createRoom:
                    MoonDashLogoHubView()
                case .createName:
                    MoonDashLogoHubView()
                case .airplayInstructions:
                    MoonDashLogoHubView()
                case .chooseRoom:
                    MoonDashLogoHubView()
                case .waitingRoom:
                    MoonDashLogoHubView()
                case .matchmaking:
                    MatchmakingHubView(router: $router, multipeerSession: multipeerSession, size: proxy.size)
                case .storyBoard:
                    StoryHubView(size: proxy.size)
                case .tutorial:
                    TutorialHubView(router: $router,  size: proxy.size)
                case .game:
                    MatchHubView(router: $router, count: multipeerSession.mcSession.connectedPeers.count, user: user, matchManager: matchManager)
                case .victoryStory:
                    Text("Victory")
                case .ranking:
                    RankingHubView(router: $router, size: proxy.size)
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
    }
}
