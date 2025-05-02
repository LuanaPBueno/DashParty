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
    

    private let columns = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]

    var body: some View {
        
            LazyVGrid(columns: columns, spacing: 10) {
                ForEach(0..<HUBPhoneManager.instance.allPlayers.count, id: \.self) { i in
                    MatchViewHub(users: users, index: i, matchManager: matchManager)
                        .border(Color.red)
                    
                }
            }
            .task{
                print("number of players: \(players.count)")
                startCheckingForAllWinners()
            }
            .onDisappear {
                timer?.invalidate()
            }
          
        
    }
    
//    private func startCheckingForAllWinners() {
//           timer?.invalidate()
//           
//           timer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: true) { _ in
//               let allWon = HUBPhoneManager.instance.allPlayers.allSatisfy { $0.youWon == true }
//               if allWon {
//                   HUBPhoneManager.instance.allPlayersFinished = true
//                   HUBPhoneManager.instance.ranking = true
//                   router = .ranking
//                   timer?.invalidate()
//               }
//           }
//       }
    
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
