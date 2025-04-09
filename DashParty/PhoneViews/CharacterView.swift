//
//  CharacterView.swift
//  DashParty
//
//  Created by Maria Eduarda Mariano on 23/03/25.
//

import SwiftUI
import CoreMotion

struct CharacterView: View {
   
    var multipeerSession : MPCSession!
    @State var navigate : Bool = false
    @State var changed: Bool = HUBPhoneManager.instance.changeScreen
    @State private var isActive = false

    
//    var users: [User]
//    var user : User
//    var matchManager: ChallengeManager
//    @State var navigateToShareScreen: Bool = false
//    
    
    var body: some View{
        ZStack{
                Image("start&tutorial")
                    .resizable()
                    .scaledToFill()
                    .edgesIgnoringSafeArea(.all)

                
//                Button {
//                    matchManager.startMatch(users: [user, User(name: "A")], myUserID: user.id)
//                    navigateToShareScreen = true
//                } label: {
//                    ZStack{
//                        
//                        Image("startButton")
//                    }
//                }
//                .navigationDestination(isPresented: $navigateToShareScreen) {
//                    ShareScreen() // Substitua por sua tela de destino
//                }
        }
    }
}


