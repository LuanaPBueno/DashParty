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

    let tutorialTexts = [
        "Keep your phone in a vertical position throughout the race.",
        "Shake your phone up and down, fast. This keeps you moving forward!",
        "Keep running and throw your arms in the air! That’s how you jump over obstacles!",
        "Hold your phone still ,  like balancing on a tightrope! Stay calm. Stay steady.",
        "Push your phone forward , like opening a heavy door! Clear the way. Keep moving.",
        "It’s game time! Have fun and go for the win!"
    ]

    let tutorialTitles = [
        "Run",
        "Breathe",
        "Balance",
        "Jump",
        "React",
        "Win"
    ]

    let tutorialImageNames = [
        "tutorialImage1",
        "tutorialImage2",
        "tutorialImage3",
        "tutorialImage4",
        "tutorialImage5",
        "tutorialImage6"
    ]

    var body: some View {
        ZStack {
            Image("backgroundPurple")
                          .resizable()
                           .scaledToFill()
                           .ignoresSafeArea()
            if !hubManager.startMatch {
                VStack {
                    if let tutorialImage = tutorialImageNames[safe: hubManager.actualTutorialIndex],
                       let tutorialText = tutorialTexts[safe: hubManager.actualTutorialIndex],
                       let tutorialTitle = tutorialTitles[safe: hubManager.actualTutorialIndex] {

                        TutorialSheet(
                            tutorialImage: tutorialImage,
                            tutorialText: tutorialText,
                            tutorialTextTitle: tutorialTitle
                        )
                        
                    }
                }
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
