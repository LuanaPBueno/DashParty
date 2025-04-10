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

    private let columns = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]

    var body: some View {
        LazyVGrid(columns: columns, spacing: 10) {
            ForEach(0..<max(2, HUBPhoneManager.instance.allPlayers.count), id: \.self) { i in
                MatchViewHub(users: users, index: i, matchManager: matchManager)
                    .border(Color.red)
                    
            }
        }
        .task{
            print("number of players: \(players.count)")
        }
    }
}
