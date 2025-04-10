//
//  YouWonView.swift
//  DashParty
//
//  Created by Luana Bueno on 28/03/25.
//

import Foundation
import SwiftUI

struct YouWonView: View {
    
    @Environment(\.dismiss) var dismiss
    
    var players: [SendingPlayer] = HUBPhoneManager.instance.allPlayers
    
    var rankedPlayers: [(player: SendingPlayer, formattedTime: String)] {
        guard !players.isEmpty else { return [] }

        return players.sorted { $0.interval < $1.interval }
            .map { player in
                let formattedTime = formatTimeInterval(player.interval)
                return (player, formattedTime)
            }
    }

    private func formatTimeInterval(_ interval: TimeInterval) -> String {
        let formatter = DateComponentsFormatter()
//        formatter.allowedUnits = [.minute, .second]
//        formatter.unitsStyle = .positional
//        formatter.zeroFormattingBehavior = .pad
        return formatter.string(from: interval) ?? "00:00"
    }
    
    var hubManager = HUBPhoneManager.instance
    
    var body: some View {
        VStack {
            Text("RACE COMPLETE!")
                .font(.system(size: 70, weight: .bold, design: .default))
                .font(.title2)
            
            Text("⎯⎯⎯⎯⎯⎯⎯⎯⎯⎯⎯⎯⎯⎯⎯⎯⎯⎯⎯⎯⎯⎯⎯⎯⎯⎯⎯⎯⎯⎯⎯⎯⎯⎯⎯⎯⎯⎯⎯")
                .font(.title2)
            
            Text("FINAL RANKING:\n")
                .font(.title)
                
            
            ForEach(Array(rankedPlayers.enumerated()), id: \.offset) { index, ranked in
                HStack {
                    Text("#\(index + 1)")
                        .font(.title3)
                        .frame(width: 30, alignment: .leading)
                    
                    Text(ranked.player.id.uuidString)
                    
                    Text(ranked.formattedTime)
                        .font(.title3)
                       
                }
                .padding(.horizontal)
                .foregroundColor(.white)
            }
            
            Text("COME ON! THINK YOU CAN GO FASTER?")
                .font(.title3)
        }

        .onAppear {
            HUBPhoneManager.instance.endedGame = true
            if hubManager.newGame {
                DispatchQueue.main.async {
                    dismiss()
                }
            }
        }
    }
}

