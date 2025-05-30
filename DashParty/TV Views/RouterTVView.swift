//
//  RouterTVView.swift
//  DashParty
//
//  Created by Victor Martins on 28/05/25.
//

import SwiftUI

struct RouterTVView: View {
    
    @Binding var router: RouterTV
    
    let user = GameInformation.instance.user
    @State var multipeerSession = MPCSessionManager.shared
    @State var matchManager = GameInformation.instance.matchManager
    var body: some View {
        ZStack {
            switch router {
            case .logo:
                MoonDashLogoTVView(router: $router)
            case .matchmaking, .characterSelection:
                GeometryReader { geo in
                    MatchmakingTVView(router: $router, multipeerSession: multipeerSession, size: geo.size)
                        .onAppear {
                            GameInformation.instance.allPlayers[0].name = "a"
                            GameInformation.instance.playername = "a"
                            MPCSessionManager.shared.host = true
                            MPCSessionManager.shared.startSession(asHost: true)
                            GameInformation.instance.roomName = "TV novíssima"
                            MPCSessionManager.shared.resetSession()
                        }
                }
//            case .characterSelection:
//                CharacterSelectionTVView(router: $router)
            
            case .story:
                GeometryReader { geo in
                    StoryHubView(size: geo.size)
                }
            case .tutorial:
                TutorialHubTVView(router: $router)
            case .game:
                MatchHubTVView(router: $router, count: multipeerSession.mcSession.connectedPeers.count, user: user, matchManager: matchManager)
            case .ranking:
                Text("")
            }
        }
        .animation(.default, value: router)
    }
}
