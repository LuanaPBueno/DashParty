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
            
            VStack(spacing: 100) {
                Spacer()
                
                Text("Race Complete!")
                    .font(.custom("TorukSC-Regular", size: 72))
                    .foregroundColor(.white)
                                
                HStack(spacing: 30) {
                    CharacterRankView(
                        frameType: CharacterFrameType(status: .winner, color: .red),
                        kikoColor: .red,
                        bannerType: .winner,
                        playerName: "derbuen",
                        time: "01:05:67"
                    )
                    
                    CharacterRankView(
                        frameType: CharacterFrameType(status: .regular, color: .blue),
                        kikoColor: .blue,
                        bannerType: .regular,
                        playerName: "ferdiler",
                        time: "01:08:30"
                    )
                    
                    CharacterRankView(
                        frameType: CharacterFrameType(status: .regular, color: .yellow),
                        kikoColor: .yellow,
                        bannerType: .regular,
                        playerName: "dartroro",
                        time: "01:15:22"
                    )
                    
                    CharacterRankView(
                        frameType: CharacterFrameType(status: .didnotfinish, color: .green),
                        kikoColor: .green,
                        bannerType: .regular,
                        playerName: "madufe",
                        time: "Did not finish"
                    )
                }
                                
                Text("Come on! Think you can beat that time?")
                    .font(.custom("TorukSC-Regular", size: 30))
                    .foregroundColor(.white)
                Spacer()

            }
        }
    }
}


#Preview {
    YouWonView(router: .constant(.start))
}
