//
//  ContinueButton.swift
//  DashParty
//
//  Created by Fernanda Auler on 14/04/25.
//

import SwiftUI

enum ColoredButtonColor { case blue, orange }

struct ColoredButtonStyle: ButtonStyle {
    
    let color: ColoredButtonColor
    var sizeFont: Double
    
    @Environment(\.isFocused) var isFocused
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(.custom("TorukSC-Light", size: CGFloat(sizeFont)))
            .foregroundColor(.white)
            .multilineTextAlignment(.center)
            .minimumScaleFactor(0.5)
            .background {
                Image(color == .orange ? "decorativeRectOrange" : "decorativeRectBlue")
                    .resizable()
                    .scaledToFit()
            }
            .scaleEffect(configuration.isPressed ? 0.975 : (isFocused ? 1.1 : 1))
            .animation(.bouncy(duration: 0.2, extraBounce: 0.125), value: isFocused)
    }
}
extension ButtonStyle where Self == ColoredButtonStyle {
    static func colored(_ color: ColoredButtonColor, fontSize: Double = 40) -> Self { .init(color: color, sizeFont: fontSize) }
}
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
