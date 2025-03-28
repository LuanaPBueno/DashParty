//
//  TutorialHubView .swift
//  DashParty
//
//  Created by Luana Bueno on 26/03/25.
//

import Foundation
import SwiftUI

struct TutorialHubView: View {
    let user = User(name: "Eu")
    @State var matchManager = ChallengeManager()
    var users: [User] = [User(name: "A"), User(name: "B")]
    @ObservedObject var hubManager = HUBPhoneManager.instance
    
    var myPlayer: Player? {
        matchManager.getPlayer(forUser: user.id)
    }

    
    var currentTutorialImage: [String] = ["tutorialBackgroundHub1", "tutorialBackgroundHub2", "tutorialBackgroundHub3", "tutorialToStart"]
    
    var body: some View {
        if !hubManager.startMatch {
            if currentTutorialImage[safe: hubManager.actualTutorialIndex] == "tutorialToStart"{
                ZStack{
                    Image("greenBackground")
                        .resizable()
                        .scaledToFill()
                        .edgesIgnoringSafeArea(.all)
                    
                    Image("startMatchButton")
                }
            
            }else{
                Image(currentTutorialImage[safe: hubManager.actualTutorialIndex] ?? "")
                    .resizable()
                    .scaledToFill()
                    .edgesIgnoringSafeArea(.all)
            }
        }else{
            MatchViewHub(users: users, user: user, matchManager: matchManager)
        }
        
    }
    
   
}

extension Array {
    subscript(safe index: Int) -> Element? {
        return indices.contains(index) ? self[index] : nil
    }
}

#Preview{
    TutorialHubView()
}
