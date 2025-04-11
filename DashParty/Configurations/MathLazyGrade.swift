//
//  MathLazyGrade.swift
//  DashParty
//
//  Created by Luana Bueno on 02/04/25.
//
import SwiftUI
import Foundation

struct MatchGridView: View {
    let count: Int
    let players = HUBPhoneManager.instance.allPlayers
    let users: [User] = HUBPhoneManager.instance.users
    let user: User
    var matchManager: ChallengeManager
    @State private var timer: Timer?
    @State private var ranking = false
    @State private var allPlayersFinished = false

    private let columns = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]

    var body: some View {
        if !ranking{
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
          
        } else{
            YouWonView()
        }
    }
    
    private func startCheckingForAllWinners() {
           timer?.invalidate()
           
           timer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: true) { _ in
               let allWon = HUBPhoneManager.instance.allPlayers.allSatisfy { $0.youWon == true }
               if allWon {
                   allPlayersFinished = true
                   ranking = true
                   timer?.invalidate() 
               }
           }
       }
   
}
