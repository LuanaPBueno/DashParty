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
    @State var currentWinner : SendingPlayer?
    @State var ranking: [SendingPlayer]?
    var index: Int
    var multipeerSession = MPCSessionManager.shared
    @State var rankingTimer: Timer?
    @State private var timer = Timer.publish(every: 0.01, on: .main, in: .common).autoconnect()
    @State var matchManager: ChallengeManager
    var currentSituation: Bool { HUBPhoneManager.instance.allPlayers[index].currentSituation }
    var currentChallenge: Challenge { HUBPhoneManager.instance.allPlayers[index].currentChallenge }
    @State var startTime = Date.now
    @State var finishTime: Date?
    @State var characterImage: Image = Image("characterFront")
    @State var winnerTimer: Timer?
    
    var body: some View {
        ZStack {
            Image("backgroundFill")
                .resizable()
                .scaledToFill()
                .edgesIgnoringSafeArea(.all)
            
            VStack{
                VStack{
                    
                    
                    
                    Image("warning")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 600) // tamanho base
                        .overlay {
                            
                            let displayedChallenge = HUBPhoneManager.instance.allPlayers[index].currentChallenge
                           
                            
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
                                            .foregroundColor(.black)
                                
                                       
                                    }
                                }
                            }
                        }
                        .task {
                            matchManager.startMatch(users: users, myUserID: HUBPhoneManager.instance.allPlayers[index].id, index: index)
                            startTime = .now
                            
                            rankingTimer = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { _ in
                                ranking = matchManager.startRankingUpdates()
                            }
                                
                            let message = "StartTime"
                                if let data = message.data(using: .utf8) {
                                    multipeerSession.sendDataToAllPeers(data: data)
                                }
                            characterImage = HUBPhoneManager.instance.allPlayers[index].userClan?.image ?? Image("characterFront")
                            HUBPhoneManager.instance.newGame = false
                            winnerTimer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { _ in
                                    self.currentWinner = matchManager.getMatchCurrentWinner()
                                }
                        }
                        }
                    characterImage
                    Text(HUBPhoneManager.instance.allPlayers[index].name)
                        .font(.custom("TorukSC-Regular", size: 64, relativeTo: .title))
                        .foregroundColor(.black)
                        .background(.white)
                
                    
                   
                }
            }
        .onDisappear {
            winnerTimer?.invalidate()
            winnerTimer = nil
            rankingTimer?.invalidate()
            rankingTimer = nil
           }
            
            
    }
}


