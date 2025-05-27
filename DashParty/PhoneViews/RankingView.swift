//
//  RankingView.swift
//  DashParty
//
//  Created by Bennett Oliveira on 07/05/25.
//

import SwiftUI

struct RankingView: View {
    @Binding var router: Router
    var isWinner: Bool = false
    var kikoType: KikoType
    
    var body: some View {
        ZStack {
            Rectangle()
                .fill(Color.black)
                .ignoresSafeArea()
            
            Image("moonlightbg")
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()
            
            Image(GameInformation.instance.allPlayers[0].userClan?.color.rawValue ?? kikoType.rawValue)
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
                        Text("Good job!")
                            .font(.custom("TorukSC-Regular", size: 22))
                            .foregroundColor(Color("customyellow"))
                            .multilineTextAlignment(.center)
                        
                        if isWinner {
                            Text("You've won the race!")
                                .font(.custom("TorukSC-Regular", size: 22))
                                .foregroundColor(Color("customyellow"))
                                .multilineTextAlignment(.center)
                            
                            Text("The forest has\n chosen its new leader")
                                .font(.custom("TorukSC-Regular", size: 22))
                                .foregroundColor(.white)
                                .multilineTextAlignment(.center)
                        } //else {
//                            Text("Not this time!")
//                                .font(.custom("TorukSC-Regular", size: 22))
//                                .foregroundColor(Color("customyellow"))
//                                .multilineTextAlignment(.center)
//                            
//                            Text("Run again. \nThe moon awaits.")
//                                .font(.custom("TorukSC-Regular", size: 22))
//                                .foregroundColor(.white)
//                                .multilineTextAlignment(.center)
//                        }
                    }
                    if MPCSessionManager.shared.host {
                        Button {
                            DispatchQueue.main.async {
                                GameInformation.instance.allPlayersFinished = false
                                GameInformation.instance.ranking = false
                                for i in 0..<GameInformation.instance.allPlayers.count {
                                    GameInformation.instance.allPlayers[i].youWon = false
                                    GameInformation.instance.allPlayers[i].interval = 0.0
                                }
                                
                            }
                            
                            GameInformation.instance.startMatch = false
                            let message = "Reset"
                            if let data = message.data(using: .utf8) {
                                MPCSessionManager.shared.sendDataToAllPeers(data: data)
                                
                            }
                            router = .tutorial
                            GameInformation.instance.matchManager.reset()
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
                    } else {
                        
                    }
                }
                Spacer()
            }
            .offset(x: 140)
        }
        .task{
            let rankingData: [String] = GameInformation.instance.allRank
            do {
                let encodedData = try JSONEncoder().encode(rankingData)
                MPCSessionManager.shared.sendDataToAllPeers(data: encodedData)
            } catch {
                print("Erro ao codificar os dados do usuário: \(error)")
            }
        }
    }
}

