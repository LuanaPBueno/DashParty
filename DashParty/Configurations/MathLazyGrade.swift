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
    let users: [User]
    let players = HUBPhoneManager.instance.allPlayers
    let user: User
    var matchManager: ChallengeManager

    private let columns = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]

    var body: some View {
        LazyVGrid(columns: columns, spacing: 10) {
            ForEach(0..<min(players.count, users.count), id: \.self) { i in
                MatchViewHub(users: users, user: users[i], index: i, matchManager: matchManager)
            }
        }
    }
}
