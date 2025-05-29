//
//  RankingHubView.swift
//  DashParty
//
//  Created by Luana Bueno on 28/03/25.
//

import Foundation
import SwiftUI

struct RankingHubView: View {
    
    @State var matchManager = GameInformation.instance.matchManager
    @Binding var router:Router
    @Environment(\.dismiss) var dismiss
    
    var players: [PlayerState] = GameInformation.instance.allPlayers
    
    var rankedPlayers: [(player: PlayerState, formattedTime: String)] {
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
    
    var hubManager = GameInformation.instance
    
    var body: some View {
        
        ZStack{
            Rectangle()
                .fill(.black)
            
            Image("backgroundNewHUB")
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()
            
            VStack {
                Spacer()
                Spacer()
                
                Text("Race Complete!")
                    .font(.custom("TorukSC-Regular", size: 72))
                    .foregroundColor(.white)
                
                Spacer()
                
                HStack(spacing: 30) {
                ForEach(Array(rankedPlayers.enumerated()), id: \.offset) { index, ranked in
                        CharacterRankView(
                            frameType: characterFrameType(ranked: ranked),
                            kikoColor: ranked.player.userClan?.color ?? .red,
                            bannerType: (GameInformation.instance.finalWinner == rankedPlayers[index].player.name ? .winner : .regular), 
                            playerName: ranked.player.name,
                            time: ranked.formattedTime
                        )
                    }
                   
                }
                
                
                Spacer()
                
                VStack(spacing: 34){
                    Text("Come on! Think you can beat that time?")
                        .font(.custom("TorukSC-Regular", size: 30))
                        .foregroundColor(.white)
                }
                Spacer()
                Spacer()
            }
            
            .onAppear {
                GameInformation.instance.endedGame = true
                
                if hubManager.newGame {
                    DispatchQueue.main.async {
                        dismiss()
                    }
                }
                
            }
        }
        .task{
            GameInformation.instance.finalWinner = rankedPlayers[0].player.name
        }
    }
    
    func characterFrameType(ranked: (player: PlayerState, formattedTime: String)) -> CharacterFrameType {
        if let kikoColor = ranked.player.userClan?.color {
            let characterColor = CharacterColor(kikoColor: kikoColor)
            return CharacterFrameType(status: .winner, color: characterColor)
        } else {
            return CharacterFrameType(status: .winner, color: .blue)
        }
    }

}

#Preview {
    RankingHubView(router: .constant(.start))
}
