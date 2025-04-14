//
//  ContinueButton.swift
//  DashParty
//
//  Created by Fernanda Auler on 14/04/25.
//

import SwiftUI

struct ContinueButton: View {
    var text:String
    var sizeFont: Int
    var body: some View {
        ZStack{
            Image("decorativeRectOrange")
                .resizable()
                .scaledToFit()
            Text(text)
                .font(.custom("TorukSC-Light", size: CGFloat(sizeFont), relativeTo: .title))
                .foregroundColor(.white)
                .multilineTextAlignment(.center)
        }
    }
}

#Preview {
    ContinueButton(text: "Continue", sizeFont: 34)
}
