//
//  NarrativeView.swift
//  DashParty
//
//  Created by Luana Bueno on 24/03/25.
//

import Foundation
import SwiftUI

struct NarrativeView: View {
    var hubManager = HUBPhoneManager.instance
    
    
    var narrativeImages = [
        "CENA_1",
        "CENA_2",
        "CENA_3",
        "CENA_4",
        "CENA_5",
    ]
    
    var narrativeTexts = [
            "I will tell you a story, the story of FOLOI.",
            "Many moons ago, in a magic forest, there was a good and just leader who guided all the clans in harmony.",
            "One day, this leader vanished UNEXPEECTEDLY! With FOLOI without protection, a new tradition was born...",
            "At each lunar cycle, four clans selects their best runner to compete for the STAFF OF THE LEADER and be the GUARDIAN FOLOI needs.",
            "Which one will take the lead?"
        ]
    
    var body: some View {
        ZStack {
            
            Image(narrativeImages[hubManager.actualPage])
                .resizable()
                .scaledToFill()
                .frame(maxWidth: .infinity)
            
//                .background
            VStack{
                Spacer()
                
                Image("caixinha1234")
                    .resizable()
                    .aspectRatio(5, contentMode: .fit)
                    .frame(height: 170)
                        .padding(.horizontal, 30)
//                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .overlay(
                Text(narrativeTexts[hubManager.actualPage])
                                        .font(.custom("TorukSC-Light", size: 20))
                                        .foregroundColor(.black)
                                        .frame(maxWidth: 600, alignment: .center)
                                       .padding()
                )
            }
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            
            #if DEBUG
            //MARK: REMOVER
            VStack {
                Spacer()
                Button(action: {
                    if hubManager.actualPage < hubManager.narrativeText.count - 1 {
                        hubManager.actualPage += 1
                    }
                }) {
                    Text("Próximo")
                        .font(.custom("TorukSC-Light", size: 24, relativeTo: .title))
                        .foregroundColor(.blue)
                }
            }
            #endif
        }
        
        }
        
    

struct NarrativeView_Previews: PreviewProvider {
    static var previews: some View {
        NarrativeView()
            .previewInterfaceOrientation(.landscapeLeft) // para simular em horizontal
    }
}

