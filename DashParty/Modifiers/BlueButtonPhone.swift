//
//  BlueButtonPhone.swift
//  DashParty
//
//  Created by Fernanda Auler on 16/04/25.
//

import SwiftUI

struct BlueButtonPhone: View {
    var text: String
    var sizeFont: Int
    var body: some View {
        GeometryReader{ geo in
            ZStack {
                Image("decorativeRectBlue")
                    .resizable()
                    .scaledToFit()
                    .frame(width: geo.size.width)
                Text(text)
                    .font(.custom("TorukSC-Light", size: CGFloat(sizeFont)))
                    .foregroundColor(.white)
                    .multilineTextAlignment(.center)
                    .minimumScaleFactor(0.5)
            }
            .aspectRatio(1/6, contentMode: .fit)
        }
        
    }
}


#Preview {
    BlueButtonPhone(text: "Continue", sizeFont: 28)
}
