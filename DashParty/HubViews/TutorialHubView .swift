//
//  TutorialHubView.swift
//  DashParty
//
//  Created by Luana Bueno on 26/03/25.
//

import Foundation
import SwiftUI

struct TutorialHubView: View {
    @Binding var router: Router
    var multipeerSession = MPCSessionManager.shared

    let user = HUBPhoneManager.instance.user
    @State var matchManager = HUBPhoneManager.instance.matchManager
    var hubManager = HUBPhoneManager.instance

    var currentTutorialImage: [String] = [
        "tutorialhub1", "tutorialhub2", "tutorialhub3",
        "tutorialhub4", "tutorialhub5", "tutorialhub6"
    ]

    var body: some View {
        ZStack {
            if !hubManager.startMatch {
                // Exibe a imagem do tutorial atual
                Image(currentTutorialImage[safe: hubManager.actualTutorialIndex] ?? "fallbackImage")
                    .resizable()
                    .scaledToFill()
                    .ignoresSafeArea()
            } else {
                // Quando o match começa, muda para a tela MatchGrid
                MatchGridView(
                    router: $router,
                    count: multipeerSession.mcSession.connectedPeers.count,
                    user: user,
                    matchManager: matchManager
                )
                .task {
                    print("Connected Peers: \(multipeerSession.mcSession.connectedPeers.count)")
                }
            }
        }
        .onAppear {
            hubManager.actualTutorialIndex = 0 // começa sempre do início
        }
    }
}

extension Array {
    subscript(safe index: Int) -> Element? {
        return indices.contains(index) ? self[index] : nil
    }
}

#Preview {
    TutorialHubView(router: .constant(.victoryStory), multipeerSession: MPCSessionManager.shared)
}
