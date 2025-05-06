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
//            VStack(spacing: 5) {
//                Text("Heads Up!")
//                    .font(.custom("TorukSC-Regular", size: 150, relativeTo: .largeTitle))
//                    .multilineTextAlignment(.center)
//                    .foregroundColor(.white)
//
//                Text("Things make way more sense after the tutorial...")
//                    .font(.custom("TorukSC-Regular", size: 130, relativeTo: .title))
//                    .multilineTextAlignment(.center)
//                    .foregroundColor(.white)
//               
//            }
            // Garante que fique na frente
            if !hubManager.startMatch {
                VStack (spacing: 80) {
                    //Spacer()
                    VStack(spacing: 10) {
                                Text("Heads Up!")
                                    .font(.custom("TorukSC-Regular", size: 120, relativeTo: .largeTitle))
                                    .multilineTextAlignment(.center)
                                    .foregroundColor(.white)

//                                Text("Things make way more sense after the tutorial...")
//                                    .font(.custom("TorukSC-Regular", size: 90, relativeTo: .title))
//                                    .multilineTextAlignment(.center)
//                                    .foregroundColor(.white)
                            }
                    .padding(.bottom, 50)
                     // esse valor ajusta o quão para cima o título vai
                    if let tutorialImage = tutorialImageNames[safe: hubManager.actualTutorialIndex],
                       let tutorialText = tutorialTexts[safe: hubManager.actualTutorialIndex],
                       let tutorialTitle = tutorialTitles[safe: hubManager.actualTutorialIndex] {

                        TutorialSheet(
                            tutorialImage: tutorialImage,
                            tutorialText: tutorialText,
                            tutorialTextTitle: tutorialTitle
                        )
                        .scaleEffect(1.5)
                       // .frame(maxWidth: 1000, maxHeight: 600)
                        
                    }
                    
                    //Spacer()
                }
                //.frame(maxHeight: .infinity)
                
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
