//
//  WarningMatch.swift
//  DashParty
//
//  Created by Fernanda Auler on 16/04/25.
//

import SwiftUI

struct WarningMatch: View {
    var warningText: String
    var body: some View {
        GeometryReader { geometry in
            let fontSize = max(geometry.size.width * 0.09, 28)

            ZStack {
                Image("warning")
                    .resizable()
                    .scaledToFit()
                    .frame(width: geometry.size.width)
                    .overlay(
                        VStack {
                            Spacer()
                            Text(warningText)
                                .font(.custom("TorukSC-Regular", size: fontSize))
                                .foregroundColor(.black)
                                .lineLimit(2)
                                .multilineTextAlignment(.center)
                                .padding(.horizontal, geometry.size.width * 0.1)
                        }
                        .padding(.vertical, geometry.size.height * 0.05)
                    )
            }
        }
        .aspectRatio(9/16, contentMode: .fit)
    }
}



#Preview {
    WarningMatch(warningText: "Run!")
}
