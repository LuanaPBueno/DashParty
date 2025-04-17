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
                //Spacer()
                VStack{
                    
                    Image("warning")
//                        .resizable()
//                        .scaledToFit()
//                        .frame(width: 300) // tamanho base
//                        .scaleEffect(currentSituation ? 1.3 : 1.0) // aumenta se estiver fazendo o desafio
//                        .animation(.easeInOut(duration: 0.4), value: currentSituation)
                        .overlay {
                            
                            let displayedChallenge = HUBPhoneManager.instance.allPlayers[index].currentChallenge
                            let displayedSituation = HUBPhoneManager.instance.allPlayers[index].currentSituation
                            let playerID = HUBPhoneManager.instance.allPlayers[index].id
                            
                            if matchManager.players.isEmpty == false {
                                if displayedChallenge == .stopped {
                                    Text("Wait for the ranking")
                                        //.background(Color.white)
                                        .font(.custom("TorukSC-Regular", size: 64, relativeTo: .title))
                                        .foregroundColor(.black)
                                    
                                } else {
                                    VStack{
                                        //Text("\(playerID)")
                                        Text("\(displayedChallenge.name)!")
                                            .font(.custom("TorukSC-Regular", size: 64, relativeTo: .title))
                                            .foregroundColor(.black)
                                        
                                        Group {
                                            switch displayedChallenge {
                                            case .running:
                                                if displayedSituation {
                                                    Text("Run")
                                                }
                //                                else {
                //                                    Text("Not Running")
                //                                }
                                            case .jumping:
                                                if displayedSituation {
                                                    Text("Jump")
                                                }
                //                                else {
                //                                    Text("Not Jumping")
                //                                }
                                            case .openingDoor:
                                                if displayedSituation {
                                                    Text("Push the vine")
                                                }
                //                                else {
                //                                    Text("Not Pushing")
                //                                }
                                            case .balancing:
                                                if displayedSituation {
                                                    Text("Balancing")
                                                }
                //                                else {
                //                                    Text("Not Balancing")
                //                                }
                                            case .stopped:
                                                    Text("You finished. Wait for the final ranking")
                                                
                                            case nil:
                                                Text("?")
                                            }
                                        }
                                        .font(.custom("TorukSC-Regular", size: 64, relativeTo: .title))
                                        .foregroundColor(.black)
                                    }
                //                    .background(Color.white)
                                    
                                }
                            }
                        }
                        .task {
                            matchManager.startMatch(users: users, myUserID: HUBPhoneManager.instance.allPlayers[index].id, index: index)
                            startTime = .now
                            characterImage = "characterBack"
                            HUBPhoneManager.instance.newGame = false
                        }
                        }
                    Image("\(characterImage)")
                    Text(HUBPhoneManager.instance.allPlayers[index].name)
                        .font(.custom("TorukSC-Regular", size: 64, relativeTo: .title))
                        .foregroundColor(.black)
                        .background(.white)
                }
            }
            
            
    }
}


