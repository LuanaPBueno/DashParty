//
//  CharacterRankView.swift
//  DashParty
//
//  Created by Bennett Oliveira on 07/05/25.
//

import SwiftUI

enum CharacterStatus {
    case winner, regular, didnotfinish
}

enum CharacterColor: String {
    case red, blue, yellow, green
}

enum KikoColor: String {
    case red = "KikoRed"
    case blue = "KikoBlue"
    case yellow = "KikoYellow"
    case green = "KikoGreen"
}

enum BannerType: String {
    case winner = "bannerGold"
    case regular = "bannerSilver"
}

struct CharacterFrameType {
    var status: CharacterStatus
    var color: CharacterColor
    
    var imageName: String {
        switch status {
        case .winner:
            return "characterFrame\(color.rawValue.capitalized)Win"
        case .regular:
            return "characterFrame\(color.rawValue.capitalized)Player"
        case .didnotfinish:
            return "characterFrame\(color.rawValue.capitalized)DNF"
        }
    }
}
extension CharacterColor {
    init(kikoColor: KikoColor) {
        switch kikoColor {
        case .red: self = .red
        case .blue: self = .blue
        case .yellow: self = .yellow
        case .green: self = .green
        }
    }
}

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
