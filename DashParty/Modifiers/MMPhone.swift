//
//  MMPhone.swift
//  DashParty
//
//  Created by Fernanda Auler on 15/04/25.
//

import SwiftUI

struct MMPhone: View {
    var playerName: String
    var sizePadding: Int
    var body: some View {
        GeometryReader { geometry in
            
            let fontSize = geometry.size.width * 0.07 < 20 ? 20 : geometry.size.width * 0.07
            
            ZStack {
                Image("phone")
                    .resizable()
                    .scaledToFit()
                    .frame(width: geometry.size.width)
                    .overlay(
                        VStack {
                            Spacer()
                            Text(playerName)
                                .font(.custom("TorukSC-Regular", size: fontSize))
                                .foregroundColor(Color(red: 126/255, green: 97/255, blue: 46/255))
                                .padding(.bottom, CGFloat(sizePadding))
                                .minimumScaleFactor(0.5)
                                .lineLimit(1)
                        }
                        .padding(.vertical, geometry.size.height * 0.15)
                    )
            }
        }
        .aspectRatio(1, contentMode: .fit)
    }
}



#Preview {
    MMPhone(playerName: "Player 1", sizePadding: 0)
}
