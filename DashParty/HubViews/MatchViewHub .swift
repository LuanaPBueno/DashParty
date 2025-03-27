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
    var body: some View {
        ZStack {
            Image("matchBackground")
                .resizable()
                .scaledToFill()
                .edgesIgnoringSafeArea(.all)
            if matchManager.players.isEmpty == false {
                let currentChallenge = matchManager.players[matchManager.currentPlayerIndex].currentChallenge
                if currentChallenge == .stopped {
                    VStack {
                        Text("Parabéns")
                            .font(.system(size: 70, weight: .bold, design: .default))
                        if let finishTime {
                            Text("Fez em \(finishTime.timeIntervalSince(startTime))")
                                .font(.system(size: 70, weight: .bold, design: .default))
                        }
                    }
                    .task { finishTime = .now }
                } else {
                    
                    VStack{
                        
                        Text("\(currentChallenge?.name ?? "no challenge")")
                            .font(.system(size: 30, weight: .bold, design: .default))
                        
                        Group {
                            switch currentChallenge {
                            case .running:
                                if matchManager.currentSituation {
                                    Text("Running")
                                } else {
                                    Text("NO Running")
                                }
                            case .jumping:
                                if matchManager.currentSituation {
                                    Text("Jumping")
                                } else {
                                    Text("NO Jumping")
                                }
                            case .openingDoor:
                                if matchManager.currentSituation {
                                    Text("OpeningDoor")
                                } else {
                                    Text("NO OpeningDoor")
                                }
                            case .balancing:
                                if matchManager.currentSituation {
                                    Text("Balancing")
                                } else {
                                    Text("NO Balancing")
                                }
                            case .stopped:
                                if matchManager.currentSituation {
                                    Text("Stopped")
                                } else {
                                    Text("NO Stopped")
                                }
                            case nil:
                                Text("?")
                            }
                        }
                        .font(.system(size: 30, weight: .bold, design: .default))
                        Text("\(matchManager.currentSituation)")
                            .font(.system(size: 30, weight: .bold, design: .default))
                    }
                }
            }
        }
        .task {
            matchManager.startMatch(users: users + [user], myUserID: user.id)
            startTime = .now
        }
    }
    
}
