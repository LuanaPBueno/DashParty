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
    var index: Int
    var multipeerSession = MPCSessionManager.shared
    @State private var timer = Timer.publish(every: 0.01, on: .main, in: .common).autoconnect()
    @State var matchManager: ChallengeManager
    var currentSituation: Bool { HUBPhoneManager.instance.allPlayers[index].currentSituation }
    var currentChallenge: Challenge { HUBPhoneManager.instance.allPlayers[index].currentChallenge }
    @State var startTime = Date.now
    @State var finishTime: Date?
    @State var characterImage: Image = Image("characterFront")

    
    var body: some View {
        
        VStack{
                
//                TimerLabel()
                
                    Image("newwarning")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 600) // tamanho base
                        .overlay {
                            
                           
                            let displayedChallenge = HUBPhoneManager.instance.allPlayers[index].currentChallenge
//                            let displayedSituation = HUBPhoneManager.instance.allPlayers[index].currentSituation
//                            let playerID = HUBPhoneManager.instance.allPlayers[index].id
//
                            if matchManager.players.isEmpty == false {
                                if displayedChallenge == .stopped {
                                    Text("Wait for the ranking")
                                        //.background(Color.white)
                                        .font(.custom("TorukSC-Regular", size: 64, relativeTo: .title))
                                        .foregroundColor(.black)
                                    
                                } else {
                                    VStack{
                                        Text("\(displayedChallenge.name)!")
                                            .font(.custom("TorukSC-Regular", size: 64, relativeTo: .title))
                                            .foregroundColor(.white)

                                    }
                                }
                            }
                        }
                        .task {
                            matchManager.startMatch(users: users, myUserID: HUBPhoneManager.instance.allPlayers[index].id, index: index)
                            startTime = .now
                            let message = "StartTime"
                                if let data = message.data(using: .utf8) {
                                    multipeerSession.sendDataToAllPeers(data: data)
                                }
                            characterImage = HUBPhoneManager.instance.allPlayers[index].userClan?.alternateImage ?? Image("characterFront")
                            HUBPhoneManager.instance.newGame = false
                        }
                    characterImage
                    Text(HUBPhoneManager.instance.allPlayers[index].name)
                        .font(.custom("TorukSC-Regular", size: 64, relativeTo: .title))
                        .foregroundColor(.white)
                        .background(Color.red.opacity(0.7))

                }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background {
                Image("gameBackground")
                    .resizable()
                    .scaledToFill()
            }
            .clipped()
            
    }
}

