//
//  InitialView.swift
//  DashParty
//
//  Created by Fernanda Auler on 12/04/25.
//

import SwiftUI
import AVFoundation

struct InitialView: View {
    @State private var breathe = true
    @State private var showCustomAlert = true
//    @EnvironmentObject var audioManager: AudioManager
    @State var audioManager: AudioManager = AudioManager()

    var body: some View {
       
        ZStack {

            // Fundo
            Image("backgroundFill")
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()
                .onAppear {
                    audioManager.playSound(named: "forest")
                            }

            // Logo centralizada com animação e dentro da safe area
            VStack {
                Image("logoBranca")
                    .resizable()
                    .scaledToFit()
                    //.frame(maxWidth: 300)
                    .padding(.horizontal, 46) // respeita laterais
                    //.padding(.top, 16) // respeita topo
                    //.padding(.bottom, 32) // respeita base
                    .scaleEffect(breathe ? 0.9 : 0.95)
                    .opacity(breathe ? 1.0 : 0.8)
                    .onAppear {
                        withAnimation(
                            .easeInOut(duration: 1.6)
                            .repeatForever(autoreverses: true)
                        ) {
                            breathe.toggle()
                        }
                    }
//                Button {
//                    audioManager.playSound(named: "music")
//                } label: {
//                    Text("Tocar musica")
//                }

            }
        }
    }
}

#Preview {
    InitialView()
        .environmentObject(AudioManager())
}
