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
        "Shake your phone up and down quickly, the faster you shake, the faster your character sprints!",
                "While running, raise your arms high to jump. Time it right to clear passing rocks!",
                "Hold your phone steady and level. If you tilt too much, you’ll fall, stay calm and centered!",
                "Thrust your phone forward to knock vines aside. One quick motion opens the path!",
                "The forest is counting on you! Race hard, trust your instincts, and claim the Staff of the Leader!"
    ]

    let tutorialTitles = [
        "Shake to RUN!",
                "JUMP to Clear!",
                "Hold to BALANCE!",
                "PUSH to Advance!",
                "Dash to GLORY!"
    ]

    let tutorialImageNames = [
        "tutorialImage3",
        "tutorialImage4",
        "tutorialImage5",
        "tutorialImage6",
        "tutorialImage7"
    ]

    var body: some View {
        ZStack {
            Image("backgroundNewHUB")
                          .resizable()
                           .scaledToFill()
                           .ignoresSafeArea()

            if !hubManager.startMatch {
                VStack (spacing: 80) {
                    Spacer()
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
                    
                    Spacer()
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
            audioManager.playSound(named: "Narrative Music")
        }
    }
}


extension Array {
    subscript(safe index: Int) -> Element? {
        return indices.contains(index) ? self[index] : nil
    }
}


