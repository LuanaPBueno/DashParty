//
//  ReadyView.swift
//  DashParty
//
//  Created by Maria Eduarda Mariano on 09/04/25.
//

import SwiftUI
import CoreMotion

struct ReadyView: View {
    @Binding var router:Router
    var multipeerSession : MPCSession!
    
    @State var navigate : Bool = false
    @State var changed: Bool = HUBPhoneManager.instance.changeScreen
    @State private var isActive = false
    
    var body: some View {
        ZStack(alignment: .leading){
            Image("backgroundPhone")
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()
            
            VStack{
                HStack{
                    Button {
                        multipeerSession.mcSession.disconnect()
                        router = .matchmaking
                    } label: {
                        Image("backButton")
                            .padding(.leading, 35)
                            .padding(.top, 35)
                    }
                }
                Spacer()
            }
            HStack {
                Spacer()

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
                Spacer()

            }
               // .padding(.vertical, 40)

            VStack {
                Spacer()
                Button {
                    router = .matchmaking
                } label: {
                    OrangeButtonPhone(text: "Ready", sizeFont: 24)
                        .frame(width:200, height: 69)
                }
                .frame(maxWidth: .infinity, alignment: .trailing) // joga o botão pra direita
                .padding(.trailing, 20) // encosta ele na direita, mas com uma margem de 40
//                .padding(.bottom, 20) // opcional: dar uma afastada da borda inferior
            }
            
        }
    }
}

#Preview {
    ReadyView(router: .constant(.airplayInstructions))
}
