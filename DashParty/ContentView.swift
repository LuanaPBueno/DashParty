//
//  ContentView.swift
//  DashParty
//
//  Created by Luana Bueno on 11/03/25.
//

import SwiftUI
import CoreMotion

struct ContentView: View {
    
    @State var user = User(name: "Eu")

//    @State var form: AnyView = AnyView(Image("orangePerson"))
//    @State private var moveBackground = false
    
    @State var matchManager = ChallengeManager()
    var myPlayer: Player? {
        matchManager.getPlayer(forUser: user.id)
    }
    var body: some View {
        ZStack{
            Image("matchBackground")
                .resizable()
                .scaledToFill()
                .edgesIgnoringSafeArea(.all)
            //MARK: Teoricamente era para movimentar a tela de fundo?:
            //MARK: --------------------------------------------------
            if let myPlayer {
                VStack {
                    Text(matchManager.debugText)
                    Image(uiImage: myPlayer.currentChallenge.animation)
                    
                    Text("Movement Intensity: \(AccelerationManager.accelerationInstance.motionIntensity, specifier: "%.2f")")
                        .font(.subheadline)
                    
                    Text("Challenge: \(myPlayer.currentChallenge.name)")
                        .font(.title)
                    
                        .padding()
                }
            } else {
                Button {
                    matchManager.startMatch(users: [user, User(name: "A"), User(name: "B")], myUserID: user.id)
                } label: {
                    Text("Start")
                }
                .buttonStyle(.borderedProminent)
            }
        }
    }
}

#Preview {
    ContentView()
}
