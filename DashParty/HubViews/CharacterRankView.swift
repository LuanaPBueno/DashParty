//
//  CharacterRankView.swift
//  DashParty
//
//  Created by Bennett Oliveira on 07/05/25.
//

import SwiftUI

struct CharacterRankView: View {
    var frameType: CharacterFrameType
    var kikoColor: KikoColor
    var bannerType: BannerType
    var playerName: String
    var time: String
    
    var body: some View {
        ZStack(alignment: .bottom) {
            Image(frameType.imageName)
                .resizable()
                .frame(width: 250, height: 400)
            
            Image(kikoColor.rawValue)
                .resizable()
                .frame(width: 230, height: 360)
            
            if frameType.status == .winner {
                Image("moonStaff")
                    .resizable()
                    .frame(width: 100, height: 300)
                    .padding(.leading, 180)
            }
            
            ZStack {
                Image(bannerType.rawValue)
                    .resizable()
                    .frame(width: 300, height: 60)
                
                VStack(spacing: 0) {
                    Text(playerName)
                        .font(.custom("Wonder-Light", size: 20))
                        .foregroundColor(
                            frameType.status == .winner
                            ? Color("RankNamertagWin")
                            : Color("RankNamertag")
                        )
                        .textCase(.uppercase)
                    
                    Text(time)
                        .font(.custom("TorukSC-Regular", size: 20))
                        .foregroundColor(
                            frameType.status == .didnotfinish
                            ? Color("RankNot")
                            : Color("RankPlayer")
                        )
                }
            }
            .padding(.bottom, 15)
        }
    }
}

#Preview {
    CharacterRankView(
        frameType: CharacterFrameType(status: .winner, color: .red),
        kikoColor: .red,
        bannerType: .winner,
        playerName: "Luanafc",
        time: "01:05:67"
    )
}
