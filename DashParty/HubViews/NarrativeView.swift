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
    var multipeerSession: MPCSession
    
    var fontSize: CGFloat {
        return UIScreen.main.bounds.width * 0.035
    }
    var iconSize: CGFloat {
        return UIScreen.main.bounds.width * 0.09
    }
    
    var number: Int {
        return hubManager.actualPage
    }
    
    var body: some View {
            ZStack {
                if hubManager.actualPage < hubManager.narrativeText.count {
                    if hubManager.narrativeText[hubManager.actualPage].values.first == true {
                        withCharacter()
                    } else {
                        withoutCharacter()
                    }
                } else {
                    Text("Fim da narrativa!")
                        .font(.custom("TorukSC-Light", size: 28, relativeTo: .title))
                        .foregroundColor(.black)
                        .multilineTextAlignment(.center)
                }
                
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
                //MARK: REMOVER
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background {
                Image("blurFlorest")
                    .resizable()
                    .scaledToFill()
                    .ignoresSafeArea()
            }
       
    }
    
    private func withoutCharacter() -> some View {
        VStack {
            
            ZStack {
                
                VStack {
                    Spacer()
                    Text(hubManager.narrativeText[hubManager.actualPage].keys.first ?? "")
                        .lineLimit(nil)
                        .foregroundColor(.black)
                        .font(.custom("TorukSC-Light", size: 32, relativeTo: .title))
                        .multilineTextAlignment(.center)
                        .padding(.horizontal, 50)
                    
                        .frame(maxWidth: .infinity)
                    
                        .background{
                            Image("decorativeRectCream")
                                .resizable()
                                .scaledToFill()
                                .padding(.horizontal, 30)
                                .frame(maxWidth: .infinity, maxHeight: .infinity)
                            
                            
                        }
                    
                    Spacer()
                    
                }
            } .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
    }
    
    private func withCharacter() -> some View {
        
        ZStack{
            
            Spacer()
                
            VStack {
                    Spacer()
                    
                    Spacer()
                    
                    Text(hubManager.narrativeText[hubManager.actualPage].keys.first ?? "")
                        .lineLimit(nil)
                        .foregroundColor(.black)
                       .font(.custom("TorukSC-Light", size: 32, relativeTo: .title))
                        .multilineTextAlignment(.center)
                        .padding(.horizontal, 50)
                    
                        .frame(maxWidth: .infinity)
                    
                        .background{
                            Image("decorativeRectCream")
                                .resizable()
                                .scaledToFill()
                                .padding(.horizontal, 30)
                                .frame(maxWidth: .infinity, maxHeight: .infinity)
                        }
                        .background (alignment: .bottom){
                            Image("characters")
                                .resizable()
                                .scaledToFill()
                                .padding(.horizontal, 30)
                                .frame(maxWidth: .infinity, maxHeight: .infinity)
                        }
                    Spacer()
                }

            switch number {
            
            case 4:
                Image("monkeyIcon")
                    .resizable()
                    .scaledToFit()
                    .frame(width: iconSize, height: iconSize)
            case 5:
                Image("frogIcon")
                    .resizable()
                    .scaledToFit()
                    .frame(width: iconSize, height: iconSize)
            case 6:
                Image("bunnyIcon")
                    .resizable()
                    .scaledToFit()
                    .frame(width: iconSize, height: iconSize)
                    .padding(.horizontal)
            case 7:
                Image("monkeyIcon")
                    .resizable()
                    .scaledToFit()
                    .frame(width: iconSize, height: iconSize)
                    .padding(.horizontal)
            case 8:
                Image("catIcon")
                    .resizable()
                    .scaledToFit()
                    .frame(width: iconSize, height: iconSize)
                    .padding(.horizontal)
            case 9:
                Image("monkeyIcon")
                    .resizable()
                    .scaledToFit()
                    .frame(width: iconSize, height: iconSize)
                    .padding(.horizontal)
            case 10:
                Image("frogIcon")
                    .resizable()
                    .scaledToFit()
                    .frame(width: iconSize, height: iconSize)
                    .padding(.horizontal)
            default:
                    Image("questionmark.circle")
                
        Spacer()
                
            }
        }
    }
}
    
#Preview {
    NarrativeView(multipeerSession: MPCSessionManager.shared)
}


