//
//  MathLazyGrade.swift
//  DashParty
//
//  Created by Luana Bueno on 02/04/25.
//
import SwiftUI
import Foundation

struct MatchGridView: View {
    @Binding var router:Router
    let count: Int
    let players = HUBPhoneManager.instance.allPlayers
    let users: [User] = HUBPhoneManager.instance.users
    let user: User
    var matchManager: ChallengeManager
    @State private var timer: Timer?
     var ranking = HUBPhoneManager.instance.ranking
     var allPlayersFinished = HUBPhoneManager.instance.allPlayersFinished
    

//    private let columns = [
//        GridItem(.flexible()),
//        GridItem(.flexible())
//    ]

    var body: some View {
        
        let totalPlayers =  HUBPhoneManager.instance.allPlayers.count
            VStack(spacing: 0){
                
                HStack(spacing: 0) {
                    MatchViewHub(users: users, index: 0, matchManager: matchManager) //SOU EU
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .clipped()
                    
                    if totalPlayers >= 2 {
                        MatchViewHub(users: users, index: 1, matchManager: matchManager) //jogador 1
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                            .clipped()
                            .task{
                                 print()
                            }

                    }
                    
                    if totalPlayers == 3 {
                        MatchViewHub(users: users, index: 2, matchManager: matchManager) //jogador 2
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                            .clipped()
                        

                    }
                }
                
                HStack(spacing: 0){
                    
                    if totalPlayers > 3 {
                        MatchViewHub(users: users, index: 2, matchManager: matchManager) //jogador 2
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                            .clipped()
                    }
                    
                    if totalPlayers == 4 {
                        MatchViewHub(users: users, index: 3, matchManager: matchManager)
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                            .clipped()
                        
//                        ZStack{
//                            VStack {
//                                HStack {
//                                    TimerLabel()
//                                }
//                            }
//                        }
                    }
                }
            }
            //        LazyVGrid(columns: 4 == 1 ? [GridItem()] : columns, spacing: 10) {
            //                ForEach(0..<4, id: \.self) { i in
            //                    MatchViewHub(users: users, index: 0, matchManager: matchManager)
            //                        .border(Color.red)
            //
            //                }
            //            }
            .task{
                print("number of players: \(players.count)")
                for (index, player) in Array(HUBPhoneManager.instance.allPlayers.enumerated()) {
                    matchManager.startMatch(users: users, myUserID: HUBPhoneManager.instance.allPlayers[index].id, index: index)
                }
                print("Created matches")
                startCheckingForAllWinners()
            }
            .onDisappear {
                timer?.invalidate()
            }
            .frame(maxHeight: .infinity)
            .ignoresSafeArea()
            
            
        
    }
    
    //MARK: Agora, quando tiver só com um jogador final correndo, o jogo já passa pra tela de ranking
    private func startCheckingForAllWinners() {
        timer?.invalidate()
        
        timer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: true) { _ in
            let players = HUBPhoneManager.instance.allPlayers
            let winnersCount = players.filter { $0.youWon == true }.count
            
            if players.count == 1 {
                if winnersCount == 1 {
                    HUBPhoneManager.instance.allPlayersFinished = true
                    HUBPhoneManager.instance.ranking = true
                    router = .ranking
                    timer?.invalidate()
                }
             
            } else {
                if winnersCount == players.count - 1 {
                    HUBPhoneManager.instance.allPlayersFinished = true
                    HUBPhoneManager.instance.ranking = true
                    router = .ranking
                    timer?.invalidate()
                }
            }
        }
    }
}
