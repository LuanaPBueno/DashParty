//
//  ProgressBar.swift
//  DashParty
//
//  Created by Luana Bueno on 21/05/25.
//

import Foundation
import SwiftUI

struct ProgressBarView: View {
    @State var imagem = Image("progressRed")
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                RoundedRectangle(cornerRadius: 20)
                    .fill(Color("customBlue").opacity(1))
                    .frame(width: 60, height: geometry.size.height)

                Rectangle()
                    .fill(Color.white)
                    .frame(width: 5, height: geometry.size.height)

                ForEach(GameInformation.instance.allPlayers) { player in
                    let progress = min(CGFloat(player.progress) / 2500.0, 1.0)

                    imageForColor(player.userClan?.originalColor)
                        .frame(width: 10, height: 10)
                        .position(
                            x: geometry.size.width / 2 + 17,
                            y: geometry.size.height * (1 - progress)
                        )
                        .animation(.easeInOut(duration: 0.3), value: player.progress)

                }
            }
        }
        .frame(width: 160, height: 500)
    }
}

func imageForColor(_ color: Color?) -> Image {
    switch color {
    case .red:
        return Image("progressRed")
    case .blue:
        return Image("progressBlue")
    case .green:
        return Image("progressGreen")
    case .yellow:
        return Image("progressYellow")
    default:
        return Image("progressRed")
    }
}
