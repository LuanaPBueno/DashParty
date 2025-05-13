//
//  MatchViewHub .swift
//  DashParty
//
//  Created by Luana Bueno on 27/03/25.
//

import Foundation
import SwiftUI
import SceneKit

struct MatchViewHub: View {
    var users: [User]
    @State var currentWinner : SendingPlayer?
    @State var ranking: [SendingPlayer]?
    @State var audioManager: AudioManager = AudioManager()
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
//        GeometryReader { proxy in
            ZStack {
                if index < matchManager.scenes.count {
                    SceneView(scene: matchManager.scenes[index])
                        .onChange(of: HUBPhoneManager.instance.allPlayers[index].currentChallenge, { oldValue, newValue in
                           // print("PROGRESS IS \(newValue)")
                            matchManager.checkAddChallenge(distance: Float(HUBPhoneManager.instance.allPlayers[index].progress), playerIndex: index)
                        })
                        .frame(width: .infinity, height: .infinity)
                        .background(.brown)
                        .ignoresSafeArea()
                }
            }
//        }
//        .frame(maxWidth: .infinity, maxHeight: .infinity)
//        .id(matchManager.scenes.count)
        .task {
//            matchManager.startMatch(users: users, myUserID: HUBPhoneManager.instance.allPlayers[index].id, index: index)
            audioManager.playSound(named: "Run Music")
            startTime = .now
            let message = "StartTime"
            if let data = message.data(using: .utf8) {
                multipeerSession.sendDataToAllPeers(data: data)
            }
            characterImage = HUBPhoneManager.instance.allPlayers[index].userClan?.image ?? Image("characterFront")
            HUBPhoneManager.instance.newGame = false
        }
//    }

//        ZStack {
//            Image("backgroundFill")
//                .resizable()
//                .scaledToFill()
//                .edgesIgnoringSafeArea(.all)
//
//            VStack{
//                VStack{
//
//                    Image("warning")
//                        .resizable()
//                        .scaledToFit()
//                        .frame(width: 600) // tamanho base
//                        .overlay {
//
//                            let displayedChallenge = HUBPhoneManager.instance.allPlayers[index].currentChallenge
//                            let displayedSituation = HUBPhoneManager.instance.allPlayers[index].currentSituation
//                            let playerID = HUBPhoneManager.instance.allPlayers[index].id
//
//                            if matchManager.players.isEmpty == false {
//                                if displayedChallenge == .stopped {
//                                    Text("Wait for the ranking")
//                                        //.background(Color.white)
//                                        .font(.custom("TorukSC-Regular", size: 64, relativeTo: .title))
//                                        .foregroundColor(.black)
//
//                                } else {
//                                    VStack{
//                                        Text("\(displayedChallenge.name)!")
//                                            .font(.custom("TorukSC-Regular", size: 64, relativeTo: .title))
//                                            .foregroundColor(.black)
//
//
//                                    }
//                                }
//                            }
//                        }
//                        .task {
//                            matchManager.startMatch(users: users, myUserID: HUBPhoneManager.instance.allPlayers[index].id, index: index)
//                            startTime = .now
//                            let message = "StartTime"
//                                if let data = message.data(using: .utf8) {
//                                    multipeerSession.sendDataToAllPeers(data: data)
//                                }
//                            characterImage = HUBPhoneManager.instance.allPlayers[index].userClan?.image ?? Image("characterFront")
//                            HUBPhoneManager.instance.newGame = false
//                        }
//                        }
//                    characterImage
//                    Text(HUBPhoneManager.instance.allPlayers[index].name)
//                        .font(.custom("TorukSC-Regular", size: 64, relativeTo: .title))
//                        .foregroundColor(.black)
//                        .background(.white)
//                }
//            }
            
            
    }
}


