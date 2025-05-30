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
    
    let user = GameInformation.instance.user
    @State var matchManager = GameInformation.instance.matchManager
    var hubManager = GameInformation.instance
    
    let basicTutorialImage = "phoneTV"
    
    var size: CGSize
    
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
        ZStack{
            if !hubManager.startMatch {
                
                VStack {
                    Text("Heads Up!")
                        .font(.custom("TorukSC-Regular", size: (size.width / 1920) * 70))              .multilineTextAlignment(.center)
                        .foregroundColor(.white)
                    
                    if let tutorialImage = tutorialImageNames[safe: hubManager.actualTutorialIndex],
                       let tutorialText = tutorialTexts[safe: hubManager.actualTutorialIndex],
                       let tutorialTitle = tutorialTitles[safe: hubManager.actualTutorialIndex] {
                        
                        TutorialSheet(
                            tutorialImage: tutorialImage,
                            tutorialText: tutorialText,
                            tutorialTextTitle: tutorialTitle,
                            size: size
                            
                        )
                        
                    }
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)

                .background {
                    Image("backgroundNewHUB")
                        .resizable()
                        .scaledToFill()
                        .ignoresSafeArea()
                }
                .onAppear {
                    hubManager.actualTutorialIndex = 0
                    audioManager.playSound(named: "Narrative Music")
                }
            }
            else {
                MatchHubView(
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
    }
}

extension Array {
    subscript(safe index: Int) -> Element? {
        return indices.contains(index) ? self[index] : nil
    }
}

#Preview {
    
    TutorialHubView(
        
        router: .constant(.start),
//        multipeerSession: MPCSessionManager.shared,
//        audioManager: AudioManager(),
//        matchManager: GameInformation.instance.matchManager,
//        hubManager: GameInformation.instance,
        size: CGSize(width: 2388, height: 1668))
}
