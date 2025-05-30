//
//  ContentView.swift
//  DashParty
//
//  Created by Luana Bueno on 11/03/25.
//

import SwiftUI

struct MoonDashLogoTVView: View {
    @Binding var router: RouterTV
    @State var audioManager: AudioManager = AudioManager()
    @State var navigate : Bool = false
    @State var changed: Bool = GameInformation.instance.changeScreen
    @State private var isActive = false
    
    @State private var breathe = true
    var body: some View {
            ZStack{
                Image("illustrationTitle")
                    .resizable()
                    .scaledToFill()
                    .ignoresSafeArea()

                VStack {
                    Spacer()
                    Image("logoBranca")
                        .resizable()
                        .scaledToFit()
                        .padding(.top, 40)
                        .scaleEffect(breathe ? 0.9 : 0.95)
                        .opacity(breathe ? 1.0 : 0.8)
                        .onAppear {
                            withAnimation(
                                .easeInOut(duration: 1.6)
                                .repeatForever(autoreverses: true)
                            ) {
                                breathe.toggle()
                            }
                            audioManager.playSound(named: "forest")

                        }
                    HStack(alignment: .center){
                        Spacer()
                        Button(action: {
                            router = .matchmaking
                        }) {
                            Text("Play")
                                .padding(150)
                        }
                        .buttonStyle(.colored(.orange, fontSize: 70))
                        .padding(.trailing, 10)
                        Spacer()
                    }
                    Spacer()
                }
            }
            
        
    }
}


#Preview {
    MoonDashLogoView(router: .constant(.start))
}
