//
//  ContinueButton.swift
//  DashParty
//
//  Created by Fernanda Auler on 14/04/25.
//

import SwiftUI

struct OrangeButtonPhone: View {
    var text: String
    var sizeFont: CGFloat // pequeno e proporcional ao botão

    var body: some View {
        ZStack {
            Image("decorativeRectOrange")
                .resizable()
                .scaledToFill()
                .frame(width: 150.25, height: 45.59)
                .clipped()

            Text(text.uppercased())
                .font(.custom("TorukSC-Light", size: sizeFont))
                .foregroundColor(.white)
                .lineLimit(1)
                .minimumScaleFactor(0.5)
                .padding(.horizontal, 9)
        }
        .frame(width: 110.25, height: 45.59)
    }
}

#Preview {
    OrangeButtonPhone(text: "Continue", sizeFont: 28)
}
