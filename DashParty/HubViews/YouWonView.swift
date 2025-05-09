//
//  YouWonView.swift
//  DashParty
//
//  Created by Luana Bueno on 28/03/25.
//

import Foundation
import SwiftUI

struct YouWonView: View {
    @State var matchManager = HUBPhoneManager.instance.matchManager
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
            Image("backgroundPurple")
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
                    DispatchQueue.main.async {
                        HUBPhoneManager.instance.allPlayersFinished = false
                        HUBPhoneManager.instance.ranking = false
                        for i in 0..<HUBPhoneManager.instance.allPlayers.count {
                            HUBPhoneManager.instance.allPlayers[i].youWon = false
                            HUBPhoneManager.instance.allPlayers[i].interval = 0.0
                        }

                            }
                    
                    HUBPhoneManager.instance.startMatch = false
                    let message = "Reset"
                        if let data = message.data(using: .utf8) {
                            MPCSessionManager.shared.sendDataToAllPeers(data: data)
                            
                        }
                    router = .tutorial
                    HUBPhoneManager.instance.matchManager.reset()
                    
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
