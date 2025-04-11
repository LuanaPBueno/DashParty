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
    
    @State var navigate: Bool = false
    
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
                    .font(.custom("TorukSC-Regular", size: 30))
                    .foregroundColor(.white)
                
               
                HStack{
                    ForEach(1...4, id: \.self) { index in
                        Image("bunnyFinal\(index)")
                            .resizable()
                            .scaledToFit()
                        
                    }
                }
                    Text("FINAL RANKING:")
                        .font(.custom("TorukSC-Regular", size: 30))
                        .foregroundColor(.white)
                    
                    ForEach(Array(rankedPlayers.enumerated()), id: \.offset) { index, ranked in
                        
                        HStack {
                            Text("#\(index + 1)")
                                .font(.title3)
                            
                            Text(ranked.player.id.uuidString)
                            
                            Text(ranked.formattedTime)
                                .font(.title3)
                            
                        }
                        .foregroundColor(.white)
                    }
                    
                    
                    
                    Button(action: {
                        navigate = true
                    }) {
                        Image("rematchButton")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 200, height: 80)
                        
                    }
                    
                    NavigationLink(
                        destination: ContentView(),
                        isActive: $navigate,
                        label: { EmptyView() }
                    )
                }
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

#Preview {
    YouWonView()
}

