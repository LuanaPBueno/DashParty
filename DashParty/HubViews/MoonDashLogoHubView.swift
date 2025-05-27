//
//  InitialView.swift
//  DashParty
//
//  Created by Fernanda Auler on 12/04/25.
//

import SwiftUI

struct MoonDashLogoHubView: View {
    @State var audioManager: AudioManager = AudioManager()
    @State private var breathe = true
    @State private var showCustomAlert = true

    var body: some View {
        
            VStack {
               
                Image("logoBranca")
                    .resizable()
                    .scaledToFit()
                    .padding(.horizontal, 50) // respeita laterais
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
                    .background{
                        Image("backgroundTitle")
                            .resizable()
                            .scaledToFill()
                            .ignoresSafeArea()
                }
            }
      }
  }

#Preview {
    MoonDashLogoHubView()
}
