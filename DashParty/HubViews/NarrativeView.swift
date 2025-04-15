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
        "narrativeImage1",
        "narrativeImage2",
        "narrativeImage3",
        "narrativeImage4",
        "narrativeImage5",
        "narrativeImage6",
        "narrativeImage7",
        "narrativeImage8",
        "narrativeImage9",
        "narrativeImage10",
        "narrativeImage11",
        "narrativeImage12",
    ]
    
    
    var body: some View {
        ZStack {
            
            Image(narrativeImages[hubManager.actualPage])
                .resizable()
                .scaledToFill()
                .frame(maxWidth: .infinity)
                .background{
                    Image("decorativeRectCream")
                        .resizable()
                        .scaledToFill()
                        .padding(.horizontal, 30)
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                    
                    
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
        
    }




