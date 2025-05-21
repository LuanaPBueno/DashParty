
//
//  NarrativeView.swift
//  DashParty
//  Created by Luana Bueno on 24/03/25.

import Foundation
import SwiftUI

struct NarrativeView: View {
    var hubManager = HUBPhoneManager.instance
    @State var audioManager: AudioManager = AudioManager()

    
    var narrativeImages = [
        "CENA_1",
        "CENA_2",
        "CENA_3",
        "CENA_4",
        "CENA_4",
        "CENA_5",
    ]
    
    var body: some View {
        ZStack {
            
            Image(narrativeImages[hubManager.actualPage])
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()
            
            VStack {
                Spacer()

                ZStack {
                    Image("caixinha12345")
                        .resizable()
                        .scaledToFit()
                    
                    Text(HUBPhoneManager.instance.narrativeText[hubManager.actualPage])
                        .font(.custom("TorukSC-Regular", size: 60)) // tamanho ajustado para não estourar a caixa
                        .foregroundColor(Color(.text))
                        .multilineTextAlignment(.center)
                        .padding(.horizontal, 30)
                }
                .padding(.bottom, 200) // distância da parte inferior da tela
                .onAppear {
                    audioManager.playSound(named: "Narrative Music")
                }
            }
            .padding(.horizontal, 50)

        }
           
        }
        
        }

#Preview {
    NarrativeView()
}
