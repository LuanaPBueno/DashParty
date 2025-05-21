//
//  ShareScreen.swift
//  DashParty
//
//  Created by Luana Bueno on 24/03/25.
//

import Foundation
import SwiftUI

struct ShareScreen: View{
    var body: some View{
        ZStack{
            Image("backgroundPhone")
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()
            
            VStack(spacing: 10){
                Text("Ready?")
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
                    
                        Text("Share your screen via AirPlay to play on the big screen!")
                            .font(.custom("TorukSC-Regular", size: 48))
                            .foregroundColor(.white)
                            .frame(width: 500)
                }
                Spacer()
                
                Text("We recommend these screens")
                    .font(.custom("Wonder-Light", size: 11))
                    .foregroundColor(.white)
                    .textCase(.uppercase)
                
                HStack(spacing: 10){
                    VStack(spacing: 5) {
                        Image(systemName: "ipad.gen2.landscape")
                            .font(.system(size: 32))
                            .bold()
                            .foregroundColor(.white)
                        
                        Text("Ipad")
                            .font(.custom("Wonder-Light", size: 11))
                            .foregroundColor(.white)
                            .textCase(.uppercase)
                    }
                    
                    VStack(spacing: 5) {
                        Image(systemName: "appletv")
                            .font(.system(size: 32))
                            .bold()
                            .foregroundColor(.white)
                        
                        Text("Apple tv")
                            .font(.custom("Wonder-Light", size: 11))
                            .foregroundColor(.white)
                            .textCase(.uppercase)
                    }
                    
                    VStack(spacing: 5) {
                        Image(systemName: "tv")
                            .font(.system(size: 32))
                            .bold()
                            .foregroundColor(.white)
                        
                        Text("Tv")
                            .font(.custom("Wonder-Light", size: 11))
                            .foregroundColor(.white)
                            .textCase(.uppercase)
                    }
                }
                .padding(.bottom, 10)

            }
        }
    }
}

#Preview {
    ShareScreen()
}
