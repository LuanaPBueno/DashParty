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
    @State var audioManager: AudioManager = AudioManager()

    let user = HUBPhoneManager.instance.user
    @State var matchManager = HUBPhoneManager.instance.matchManager
    var hubManager = HUBPhoneManager.instance
    
    let basicTutorialImage = "phoneTV"

    let tutorialTexts = [
        "Keep your phone in a vertical position throughout the race.",
        "Shake your phone up and down, fast. \nThis keeps you moving forward!",
        "Keep running and throw your arms in the air! \nThat’s how you jump over obstacles!",
        "Hold your phone still in a horizontal \nposition, like balancing on a bridge! \nStay calm and stay steady.",
        "Push your phone forward to push away the vines! \nClear the way and keep moving!",
        "It’s game time! Have fun and go for the win!"
    ]

    let tutorialTitles = [
        "Run",
        "Run",
        "Jump",
        "Bridge",
        "Vines",
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
            Image("backgroundNewHUB")
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
                    .padding(.bottom, 100)
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
            audioManager.playSound(named: "Narrative Music")
        }
    }
}


extension Array {
    subscript(safe index: Int) -> Element? {
        return indices.contains(index) ? self[index] : nil
    }
}


