//
//  CharacterView.swift
//  DashParty
//
//  Created by Maria Eduarda Mariano on 23/03/25.
//

import SwiftUI
import CoreMotion

struct CharacterView: View {
    var users: [User]
    var user : User
    var matchManager: ChallengeManager
    
    
    var body: some View{
        ZStack{
            Image("blueBackground")
            VStack{
                Image("comandCharacter")
                
                Button {
                    matchManager.startMatch(users: [user, User(name: "A")], myUserID: user.id)
                } label: {
                    Image("startButton")
                }
            }
        }
    }
}


