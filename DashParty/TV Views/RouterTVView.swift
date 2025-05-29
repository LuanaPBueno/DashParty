//
//  RouterTVView.swift
//  DashParty
//
//  Created by Victor Martins on 28/05/25.
//

import SwiftUI

struct RouterTVView: View {
    
    @Binding var router: RouterTV
    
    @State var multipeerSession = MPCSessionManager.shared
    
    var body: some View {
        ZStack {
            switch router {
            case .logo:
                MoonDashLogoTVView(router: $router)
            case .matchmaking:
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
            case .characterSelection:
                Text("")
            case .story:
                Text("")
            case .tutorial:
                Text("")
            case .game:
                Text("")
            case .ranking:
                Text("")
            }
        }
        .animation(.default, value: router)
    }
}
