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
    
    var rankedPlayers = GameInformation.instance.getRankedPlayers()
    
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
                GameInformation.instance.finalWinner = rankedPlayers[0].player.name
                GameInformation.instance.endedGame = true
                
                if hubManager.newGame {
                    DispatchQueue.main.async {
                        dismiss()
                    }
                }
                
            }
        }    }
    
    func characterFrameType(ranked: (player: PlayerState, formattedTime: String)) -> CharacterFrameType {
        let isWinner = (GameInformation.instance.finalWinner == ranked.player.name)
        let status: CharacterStatus = isWinner ? .winner : .regular
        
        if let kikoColor = ranked.player.userClan?.color {
            let characterColor = CharacterColor(kikoColor: kikoColor)
            return CharacterFrameType(status: status, color: characterColor)
        } else {
            return CharacterFrameType(status: status, color: .blue)
        }
    }

}

#Preview {
    RankingHubView(router: .constant(.start))
}
