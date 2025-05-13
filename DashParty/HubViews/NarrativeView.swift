
//
//  NarrativeView.swift
//  DashParty
//  Created by Luana Bueno on 24/03/25.

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
    
    var body: some View {
        ZStack {
            
            Image(narrativeImages[hubManager.actualPage])
                .resizable()
                .aspectRatio(contentMode: .fill)
//                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .ignoresSafeArea()
                    .clipped()
            
            VStack {
                Spacer()

                Image("caixinha12345")
                    .resizable()
                    .scaledToFit()
                    .padding(.horizontal, 80)
                    .overlay {
                        // O texto dentro da caixinha, centralizado e com margens internas
                        Text(HUBPhoneManager.instance.narrativeText[hubManager.actualPage])
                            .font(.custom("TorukSC-Regular", size: 65 /*,relativeTo: .largeTitle*/))
                            .foregroundColor(.black)
                            .multilineTextAlignment(.center)
                            .padding(.horizontal, 300) // margem interna dentro da caixinha
                            .padding(.vertical, 20)
                    }
                    .padding(.bottom, 320)
            }
            .frame(maxWidth: .infinity,/* maxHeight: .infinity,*/ alignment: .bottom)}
           
        }
        
        }

#Preview {
    NarrativeView()
}
