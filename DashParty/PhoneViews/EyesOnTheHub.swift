//
//  EyesOnTheHub.swift
//  DashParty
//
//  Created by Fernanda Auler on 12/04/25.
//

import SwiftUI

struct EyesOnTheHub: View {
    var body: some View {
        ZStack {
            Image("backgroundPhone")
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()
            
            VStack {
                Text("Ready! Set! Go!")
                    .font(.custom("TorukSC-Regular", size: 22))
                    .foregroundColor(.white)
                    .textCase(.uppercase)
                    .padding(.top, 40)
                
                Spacer()
                
                HStack(spacing: 30) {
                    
                    Image(systemName: "airplay.video")
                        .font(.system(size: 48))
                        .bold()
                        .foregroundColor(.white)
                    
                    Text("Eyes on the Hub!")
                        .font(.custom("TorukSC-Regular", size: 48))
                        .foregroundColor(.white)
                }
                .padding(.bottom, 40)
                Spacer()
            }
        }
    }
}

#Preview {
    EyesOnTheHub()
}
