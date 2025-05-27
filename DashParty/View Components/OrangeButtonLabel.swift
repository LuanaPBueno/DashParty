//
//  ContinueButton.swift
//  DashParty
//
//  Created by Fernanda Auler on 14/04/25.
//

import SwiftUI

struct OrangeButtonLabel: View {
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
                    .font(.custom("TorukSC-Light", size: CGFloat(sizeFont)))
                    .foregroundColor(.white)
                    .multilineTextAlignment(.center)
                    .minimumScaleFactor(0.5)
            }
            //.aspectRatio(1/6, contentMode: .fit)
//        }
        
    }
}

#Preview {
    OrangeButtonLabel(text: "Continue", sizeFont: 28)
}


//struct ContinueButton: View {
//    var text: String
//    var sizeFont: Int
//
//    var body: some View {
//        ZStack {
//            Image("decorativeRectOrange")
//                .resizable()
//                .scaledToFit()
//            Text(text)
//                .font(.custom("TorukSC-Light", size: CGFloat(sizeFont)))
//                .foregroundColor(.white)
//                .multilineTextAlignment(.center)
//                .minimumScaleFactor(0.5)
//        }
//    }
//}
//
//
//#Preview {
//    ContinueButton(text: "Continue", sizeFont: 34)
//}
