
//
//  StoryHubView.swift
//  DashParty
//  Created by Luana Bueno on 24/03/25.

import Foundation
import SwiftUI

struct StoryHubView: View {
    var hubManager = GameInformation.instance
    @State var audioManager: AudioManager = AudioManager()

    var size: CGSize
    var narrativeImages = [
        "CENA_1",
        "CENA_2",
        "CENA_3",
        "CENA_4",
        "CENA_4",
        "CENA_5",
    ]
    
    var body: some View {
            
            VStack {
                
                Spacer()
                    
                    Text(GameInformation.instance.narrativeText[hubManager.actualPage])
                    .font(.custom("TorukSC-Regular", size: (size.width / 1920) * 38)) // tamanho ajustado para não estourar a caixa
                        .foregroundColor(.text)
                        .padding(.vertical, 80)
                        .padding(.horizontal, 40)
                        .multilineTextAlignment(.center)
                        .frame(width: size.width * 0.85, height: size.width * 0.15)

                        .background{
                            Image("caixinha12345")
                                .resizable()
                                .frame(width: size.width * 0.85, height: size.width * 0.12)

                                

                        }
                
                  }
            .padding(.bottom, 15)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background {
                
                Image(narrativeImages[hubManager.actualPage])
                    .resizable()
                    .scaledToFill()
                    .ignoresSafeArea()
                
            }
            .onAppear {
                audioManager.playSound(named: "Narrative Music")
            }
           
        }
        
    }

#Preview {
    let hubManager = GameInformation.instance
    hubManager.actualPage = 0
   

    return StoryHubView(
        size: CGSize(width: 2388, height: 1668)
    )
}
