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
    
    let basicTutorialImage = "phoneTV"

    var body: some View {
        ZStack {
            Image("backgroundPurple")
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()
            
            if !hubManager.startMatch {
                VStack {
                    Text("Heads UP!")
                        .font(.custom("TorukSC-Regular", size: 80, relativeTo: .largeTitle))
                    
                    Text("Things make way more sense after the tutorial.")
                        .font(.custom("TorukSC-Regular", size: 50, relativeTo: .title))
                    
                    Image("\(basicTutorialImage)\(hubManager.actualTutorialIndex + 1)")
                        .resizable()
                        .scaledToFit()
                        .frame(
                            width: UIScreen.main.bounds.width * 1.6,
                            height: UIScreen.main.bounds.width * 0.95
                        )
                }
                .foregroundStyle(.white)
                .padding()
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            } else {
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
            hubManager.actualTutorialIndex = 0
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
