//
//  MatchViewHub .swift
//  DashParty
//
//  Created by Luana Bueno on 27/03/25.
//

import Foundation
import SwiftUI

struct MatchViewHub: View {
    var users: [User]
    var user: User
    var matchManager: ChallengeManager  // Usando o matchManager existente
    @State var currentSituation: String = ""
    
    var body: some View {
        ZStack {
            Image("matchBackground")
                .resizable()
                .scaledToFill()
                .edgesIgnoringSafeArea(.all)
            
          
        }
        .task {
            matchManager.startMatch(users: users + [user], myUserID: user.id)
        }
    }
}
