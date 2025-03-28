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
    var user: User
    var matchManager: ChallengeManager  // Usando o matchManager existente
    @State var currentSituation: String = ""
    
    @State var startTime = Date.now
    @State var finishTime: Date?
    @State var characterImage: String = "characterFront"
    
    var body: some View {
        ZStack {
            Image("matchBackground")
                .resizable()
                .scaledToFill()
                .edgesIgnoringSafeArea(.all)
            VStack{
                Spacer()
            VStack{
                Spacer()
                Image("\(characterImage)")
                   
                    
                Spacer()
            }
        }
         
            if matchManager.players.isEmpty == false {
                let currentChallenge = matchManager.players[matchManager.currentPlayerIndex].currentChallenge
                if currentChallenge == .stopped {
                    VStack {
                        Text("Congratulations")
                            .font(.system(size: 70, weight: .bold, design: .default))
                        if let finishTime {
                            Text("You did it in\(finishTime.timeIntervalSince(startTime))")
                                .font(.system(size: 70, weight: .bold, design: .default))
                        }
                    }
                    .task { finishTime = .now }
                } else {
                    
                    VStack{
                        
                        Text("Current challenge: \(currentChallenge?.name ?? "no challenge")")
                            .font(.custom("Prompt-Black",size: 64))
                            .foregroundColor(.black)
                        
                        Group {
                            switch currentChallenge {
                            case .running:
                                if matchManager.currentSituation {
                                    Text("You are running")
                                } else {
                                    Text("You are not running")
                                }
                            case .jumping:
                                if matchManager.currentSituation {
                                    Text("You are jumping")
                                } else {
                                    Text("You are not jumping")
                                }
                            case .openingDoor:
                                if matchManager.currentSituation {
                                    Text("You are opening the door")
                                } else {
                                    Text("You are not opening the door")
                                }
                            case .balancing:
                                if matchManager.currentSituation {
                                    Text("You are balancing")
                                } else {
                                    Text("You are not balancing")
                                }
                            case .stopped:
                                if matchManager.currentSituation {
                                    Text("You stopped")
                                } else {
                                    
                                }
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
            matchManager.startMatch(users: users + [user], myUserID: user.id)
            startTime = .now
            characterImage = "characterBack"
        }
    }
}
