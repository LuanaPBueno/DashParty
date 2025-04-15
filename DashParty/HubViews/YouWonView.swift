//
//  YouWonView.swift
//  DashParty
//
//  Created by Luana Bueno on 28/03/25.
//

import Foundation
import SwiftUI

struct YouWonView: View {
    @Binding var router:Router
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
        formatter.allowedUnits = [.minute, .second]
        formatter.unitsStyle = .positional
        formatter.zeroFormattingBehavior = .pad
        return formatter.string(from: interval) ?? "00:00"
    }
    
    var hubManager = HUBPhoneManager.instance
    
    var body: some View {
        
        ZStack{
            Image("purpleBackground")
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()
            
            VStack {
                Spacer()
                
                Text("RACE COMPLETE!")
                    .font(.custom("TorukSC-Regular", size: 60))
                    .foregroundColor(.white)
                
                
                Text("FINAL RANKING:\n")
                    .font(.custom("TorukSC-Regular", size: 30))
                    .foregroundColor(.white)
                
                ForEach(Array(rankedPlayers.enumerated()), id: \.offset) { index, ranked in
                    HStack {
                        Text("#\(index + 1)")
                            .font(.title3)
                            .frame(width: 30, alignment: .leading)
                        
                        Text(ranked.player.name)
                        
                        Text(ranked.formattedTime)
                            .font(.title3)
                        
                    }
                    .padding(.horizontal)
                    .foregroundColor(.white)
                }
                
                Spacer()
                
                Button {
                    router = .start
                } label: {
                    Text("Play again")
                        .font(.custom("TorukSC-Regular", size: 25))
                        .foregroundColor(.white)
                        .background(
                            Image("decorativeRectOrange")
                        )
                }
                
                Spacer()
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
}
#Preview {
   YouWonView(router: .constant(.start))

}
