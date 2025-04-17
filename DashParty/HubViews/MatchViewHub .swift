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
    @State var characterImage: String = "characterFront"
    
    var body: some View {
        ZStack {
            Image("backgroundFill")
                .resizable()
                .scaledToFill()
                .edgesIgnoringSafeArea(.all)
            
            VStack{
                Spacer()
                VStack{
                    Text(HUBPhoneManager.instance.allPlayers[index].name)
                        .font(.custom("Prompt-Black",size: 64))
                        .foregroundColor(.black)
                        .background(Color.white)
                    Spacer()
                    Image("\(characterImage)")
                    Spacer()
                }
            }
            
            let displayedChallenge = HUBPhoneManager.instance.allPlayers[index].currentChallenge
            let displayedSituation = HUBPhoneManager.instance.allPlayers[index].currentSituation
            let playerID = HUBPhoneManager.instance.allPlayers[index].id
            
            if matchManager.players.isEmpty == false {
                if displayedChallenge == .stopped {
                    Text("Você acabou, espere pelo ranking")
                        .background(Color.white)
                        .font(.custom("Prompt-Black",size: 64))
                        .foregroundColor(.black)
                    
                } else {
                    VStack{
                        Text("\(playerID)")
                        Text("Current challenge: \(displayedChallenge.name)")
                            .font(.custom("Prompt-Black",size: 64))
                            .foregroundColor(.black)
                        
                        Group {
                            switch displayedChallenge {
                            case .running:
                                if displayedSituation {
                                    Text("You are running")
                                } else {
                                    Text("You are not running")
                                }
                            case .jumping:
                                if displayedSituation {
                                    Text("You are jumping")
                                } else {
                                    Text("You are not jumping")
                                }
                            case .openingDoor:
                                if displayedSituation {
                                    Text("You are opening the door")
                                } else {
                                    Text("You are not opening the door")
                                }
                            case .balancing:
                                if displayedSituation {
                                    Text("You are balancing")
                                } else {
                                    Text("You are not balancing")
                                }
                            case .stopped:
                                    Text("You finished. Wait for the final ranking")
                                
                            case nil:
                                Text("?")
                                
                            
                            }
                        }
                        .font(.custom("Prompt-ExtraBold",size: 64))
                        .foregroundColor(.black)
                    }
                    .background(Color.white)
                    
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
            characterImage = "characterBack"
            HUBPhoneManager.instance.newGame = false
        }
    }
}
