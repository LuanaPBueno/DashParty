//
//  ContinueButton.swift
//  DashParty
//
//  Created by Fernanda Auler on 14/04/25.
//

import SwiftUI

struct OrangeButtonPhone: View {
    var text: String
    var sizeFont: Int
    var body: some View {
        
//        GeometryReader{ geo in
            ZStack {
                Image("decorativeRectOrange")
                    .resizable()
                    .scaledToFit()
//                    .frame(width: geo.size.width)
                Text(text)
                    .font(.custom("TorukSC-Regular", size: CGFloat(sizeFont)))
                    .textCase(.uppercase)
                    .foregroundColor(.white)
                    .multilineTextAlignment(.center)
                    .minimumScaleFactor(0.5)
            }
            //.aspectRatio(1/6, contentMode: .fit)
//        }
        
    }
}

#Preview {
    OrangeButtonPhone(text: "Continue", sizeFont: 28)
}
