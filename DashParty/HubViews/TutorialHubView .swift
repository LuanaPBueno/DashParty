//
//  TutorialHubView .swift
//  DashParty
//
//  Created by Luana Bueno on 26/03/25.
//

import Foundation
import SwiftUI

struct TutorialHubView: View {
    var multipeerSession = MPCSessionManager.shared

    let user = HUBPhoneManager.instance.user
    @State var matchManager = HUBPhoneManager.instance.matchManager
    var users: [User] = []
    var hubManager = HUBPhoneManager.instance
    
    var myPlayer: Player? {
        matchManager.getPlayer(forUser: user.id)
    }

    
    var currentTutorialImage: [String] = ["tutorialBackgroundHub1", "tutorialBackgroundHub2", "tutorialBackgroundHub3", "tutorialToStart"]
    
    var body: some View {
        if !hubManager.startMatch {
            if currentTutorialImage[safe: hubManager.actualTutorialIndex] == "tutorialToStart"{
                
                    
                    Image("startMatchButton")
                
            
            }else{
                Image(currentTutorialImage[safe: hubManager.actualTutorialIndex] ?? "")
                    .resizable()
                    .scaledToFill()
                    .edgesIgnoringSafeArea(.all)
            }
        }else{
            MatchGridView(count: multipeerSession.mcSession.connectedPeers.count, user: user, matchManager: matchManager)
                .task{
                    print(multipeerSession.mcSession.connectedPeers.count)
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
    TutorialHubView(multipeerSession: MPCSessionManager.shared)
}
