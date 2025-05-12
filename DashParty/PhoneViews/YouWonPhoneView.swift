//
//  YouWonPhoneView.swift
//  DashParty
//
//  Created by Bennett Oliveira on 07/05/25.
//

import SwiftUI

enum KikoType: String {
    case red = "KikoRed"
    case blue = "KikoBlue"
    case yellow = "KikoYellow"
    case green = "KikoGreen"
}

struct YouWonPhoneView: View {
    @Binding var router: Router
    var isWinner: Bool
    var kikoType: KikoType
    
    var body: some View {
        ZStack {
            Image("moonlightbg")
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()
            
            Image(kikoType.rawValue)
                .resizable()
                .scaledToFit()
                .scaleEffect(0.5)
                .ignoresSafeArea()
            
            if isWinner {
                Image("Kuto")
                    .resizable()
                    .scaledToFit()
                    .scaleEffect(0.8)
                    .offset(x: 300, y: 100)
                    .ignoresSafeArea()
                
                Image("moonStaff")
                    .resizable()
                    .scaledToFit()
                    .scaleEffect(0.5)
                    .offset(x: 62)
                    .ignoresSafeArea()
            }
            
            HStack {
                VStack(spacing: 25) {
                    VStack(spacing: 5) {
                        if isWinner {
                            Text("You've won the race!")
                                .font(.custom("TorukSC-Regular", size: 22))
                                .foregroundColor(Color("customyellow"))
                                .multilineTextAlignment(.center)
                            
                            Text("The forest has\n chosen its new leader")
                                .font(.custom("TorukSC-Regular", size: 22))
                                .foregroundColor(.white)
                                .multilineTextAlignment(.center)
                        } else {
                            Text("Not this time!")
                                .font(.custom("TorukSC-Regular", size: 22))
                                .foregroundColor(Color("customyellow"))
                                .multilineTextAlignment(.center)
                            
                            Text("Run again. \nThe moon awaits.")
                                .font(.custom("TorukSC-Regular", size: 22))
                                .foregroundColor(.white)
                                .multilineTextAlignment(.center)
                        }
                    }
                    
                    Button {
                    } label: {
                        Text("PLAY AGAIN")
                            .font(.custom("TorukSC-Regular", size: 18, relativeTo: .body))
                            .foregroundColor(.white)
                            .background(
                                Image("decorativeRectOrange")
                                    .resizable()
                                    .scaleEffect(2)
                            )
                    }
                }
                Spacer()
            }
            .offset(x: 140)
        }
    }
}

#Preview {
    YouWonPhoneView(router: .constant(.ranking), isWinner: true, kikoType: .red)
}
