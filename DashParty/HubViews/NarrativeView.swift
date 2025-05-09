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
    
  
    
    
    var body: some View {
        ZStack {
            
            Image(narrativeImages[hubManager.actualPage])
                .resizable()
                .scaledToFill()
                .frame(maxWidth: .infinity)
//                .background{
            
            VStack {
                Spacer()
            
                    Image("caixinha1234")
                    .resizable()
                                      .aspectRatio(5, contentMode: .fit)
                                      .frame(height: 170)
                                      .padding(.horizontal, 30)
                                      .overlay(
                                        Text(HUBPhoneManager.instance.narrativeText[hubManager.actualPage])
                                              .font(.custom("TorukSC-Light", size: 20))
                                              .foregroundColor(.black)
                                              .multilineTextAlignment(.center)
                                              .padding(.horizontal, 40) // margem interna à esquerda e direita
                                                      .padding(.vertical, 20)                                      )
                              }
                          }
                    
                
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            
           
        }
        
        }

#Preview {
    NarrativeView()
}


