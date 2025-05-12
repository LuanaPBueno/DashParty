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
        
        let finishedPlayers = players.filter { $0.interval > 0.0 }
        let unfinishedPlayers = players.filter { $0.interval == 0.0 }
        
        let sortedFinished = finishedPlayers.sorted { $0.interval < $1.interval }
            .map { player in
                let formattedTime = formatTimeInterval(player.interval)
                return (player, formattedTime)
            }
        
        let sortedUnfinished = unfinishedPlayers.map { player in
            (player, "Did not finish")
        }
        
        return sortedFinished + sortedUnfinished
    }
    
    private func formatTimeInterval(_ interval: TimeInterval) -> String {
        let minutes = Int(interval) / 60
        let seconds = Int(interval) % 60
        let milliseconds = Int((interval - Double(Int(interval))) * 100)
        
        return String(format: "%02d:%02d:%02d", minutes, seconds, milliseconds)
    }
    
    var hubManager = HUBPhoneManager.instance
    
    var body: some View {
        
        ZStack{
            Rectangle()
                .fill(.black)
            
            Image("patternBackground")
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()
            
            VStack {
                Spacer()
                
                Text("Race Complete!")
                    .font(.custom("TorukSC-Regular", size: 72))
                    .foregroundColor(.white)
                
                Spacer()
                
                ForEach(Array(rankedPlayers.enumerated()), id: \.offset) { index, ranked in
                    HStack(spacing: 30) {
                        CharacterRankView(
                            frameType: CharacterFrameType(status: .winner, color: .red),
                            kikoColor: .red,
                            bannerType: .winner,
                            playerName: ranked.player.name,
                            time: ranked.formattedTime
                        )
                    }
                   
                }
                
                
                Spacer()
                
                VStack(spacing:34) {
                    Text("Come on! Think you can beat that time?")
                        .font(.custom("TorukSC-Regular", size: 30))
                        .foregroundColor(.white)
                    
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
                        Text("PLAY AGAIN")
                            .font(.custom("TorukSC-Regular", size: 32))
                            .foregroundColor(.white)
                            .background(
                                Image("decorativeRectOrange")
                                    .resizable()
                                    .scaleEffect(1.5)                            )
                    }
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
