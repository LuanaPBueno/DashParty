//
//  YouWonPhoneView.swift
//  DashParty
//
//  Created by Bennett Oliveira on 07/05/25.
//

import SwiftUI

enum KikoType: String {
    case red = "KikoRed"
    case blue = "KikoBlue"
    case yellow = "KikoYellow"
    case green = "KikoGreen"
}

struct YouWonPhoneView: View {
    @Binding var router: Router
    var isWinner: Bool
    var kikoType: KikoType
    
    var body: some View {
        ZStack {
            Image("moonlightbg")
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()
            
            Image(kikoType.rawValue)
                .resizable()
                .scaledToFit()
                .scaleEffect(0.5)
                .ignoresSafeArea()
            
            if isWinner {
                Image("Kuto")
                    .resizable()
                    .scaledToFit()
                    .scaleEffect(0.8)
                    .offset(x: 300, y: 100)
                    .ignoresSafeArea()
                
                Image("moonStaff")
                    .resizable()
                    .scaledToFit()
                    .scaleEffect(0.5)
                    .offset(x: 62)
                    .ignoresSafeArea()
            }
            
            HStack {
                VStack(spacing: 25) {
                    VStack(spacing: 5) {
                        if isWinner {
                            Text("You've won the race!")
                                .font(.custom("TorukSC-Regular", size: 22))
                                .foregroundColor(Color("customyellow"))
                                .multilineTextAlignment(.center)
                            
                            Text("The forest has\n chosen its new leader")
                                .font(.custom("TorukSC-Regular", size: 22))
                                .foregroundColor(.white)
                                .multilineTextAlignment(.center)
                        } else {
                            Text("Not this time!")
                                .font(.custom("TorukSC-Regular", size: 22))
                                .foregroundColor(Color("customyellow"))
                                .multilineTextAlignment(.center)
                            
                            Text("Run again. \nThe moon awaits.")
                                .font(.custom("TorukSC-Regular", size: 22))
                                .foregroundColor(.white)
                                .multilineTextAlignment(.center)
                        }
                    }
                    
                    Button {
                        DispatchQueue.main.async {
                           HUBPhoneManager.instance.allPlayersFinished = false
                           HUBPhoneManager.instance.ranking = false
                           for i in 0..<HUBPhoneManager.instance.allPlayers.count {
                               HUBPhoneManager.instance.allPlayers[i].youWon = false
                               HUBPhoneManager.instance.allPlayers[i].interval = 0.0
                           }
   
                               }
   
                       HUBPhoneManager.instance.startMatch = false
                       let message = "Reset"
                           if let data = message.data(using: .utf8) {
                               MPCSessionManager.shared.sendDataToAllPeers(data: data)
   
                           }
                       router = .tutorial
                       HUBPhoneManager.instance.matchManager.reset()
                    } label: {
                        Text("PLAY AGAIN")
                            .font(.custom("TorukSC-Regular", size: 18, relativeTo: .body))
                            .foregroundColor(.white)
                            .background(
                                Image("decorativeRectOrange")
                                    .resizable()
                                    .scaleEffect(2)
                            )
                    }
                }
                Spacer()
            }
            .offset(x: 140)
        }
    }
}

#Preview {
    YouWonPhoneView(router: .constant(.ranking), isWinner: true, kikoType: .red)
}
