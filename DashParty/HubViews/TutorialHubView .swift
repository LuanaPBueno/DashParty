//
//  TutorialHubView .swift
//  DashParty
//
//  Created by Luana Bueno on 26/03/25.
//

import Foundation
import SwiftUI

struct TutorialHubView: View {
    @Binding var router:Router
    var multipeerSession = MPCSessionManager.shared

    let user = HUBPhoneManager.instance.user
    @State var matchManager = HUBPhoneManager.instance.matchManager
    var users: [User] = []
    var hubManager = HUBPhoneManager.instance
    
    var myPlayer: Player? {
        matchManager.getPlayer(forUser: user.id)
    }

    
    var currentTutorialImage: [String] = ["tutorialhub1", "tutorialhub2", "tutorialhub3", "tutorialhub4", "tutorialhub5", "tutorialhub6" ]
    
    var body: some View {
        VStack{
            if !hubManager.startMatch {
                if currentTutorialImage[safe: hubManager.actualTutorialIndex] == "tutorialhub6"{
                    Image("decorativeRectBlue")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 150, height: 60)
                    
                }else{
                    Image(currentTutorialImage[safe: hubManager.actualTutorialIndex] ?? "")
                        .resizable()
                        .scaledToFill()
                        .edgesIgnoringSafeArea(.all)
                }
            }else{
                MatchGridView(router: $router, count: multipeerSession.mcSession.connectedPeers.count, user: user, matchManager: matchManager)
                    .task{
                        print(multipeerSession.mcSession.connectedPeers.count)
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
    TutorialHubView(router: .constant(.victoryStory), multipeerSession: MPCSessionManager.shared)
}
