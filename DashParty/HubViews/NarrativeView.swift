//
//  NarrativeView.swift
//  DashParty
//
//  Created by Luana Bueno on 24/03/25.
//

import Foundation
import SwiftUI

struct NarrativeView: View {
    @ObservedObject var hubManager = HUBPhoneManager.instance
    
    var fontSize: CGFloat {
        return UIScreen.main.bounds.width * 0.035
    }
    var iconSize: CGFloat {
        return UIScreen.main.bounds.width * 0.09
    }
    
    var body: some View {
        if !hubManager.passToTutorialView {
            ZStack {
                if hubManager.actualPage < hubManager.narrativeText.count {
                    if hubManager.narrativeText[hubManager.actualPage].values.first == true {
                        withCharacter()
                    } else {
                        withoutCharacter()
                    }
                } else {
                    Text("Fim da narrativa!")
                        .font(.custom("Prompt-Regular", size: fontSize))
                        .foregroundColor(.black)
                        .multilineTextAlignment(.center)
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background {
                Image("narrativeBackground")
                    .resizable()
                    .scaledToFill()
                    .edgesIgnoringSafeArea(.all)
            }
        } else{
            TutorialHubView()
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
                        .font(.custom("Prompt-Regular", size: fontSize))
                        .multilineTextAlignment(.center)
                        .padding(.horizontal, 80)
                    
                        .frame(maxWidth: .infinity)
                    
                        .background{
                            Image("narrativeTextBackground")
                                .resizable()
                                .scaledToFill()
                                .padding(.horizontal, 30)
                            
                            
                            
                            
                        }
                    Spacer()
                    ///MARK: TIRAR
                    VStack{
                        Button(action: {
                            if hubManager.actualPage < hubManager.narrativeText.count - 1 {
                                hubManager.actualPage += 1
                            }
                        }) {
                            Text("Próximo")
                                .font(.custom("Prompt-Regular", size: fontSize))
                                .foregroundColor(.blue)
                                .cornerRadius(10)
                        }
                    }
                    ///MARK: TIRAR

                    
                }
                
                
            }
        }
    }
    
    private func withCharacter() -> some View {
        
        ZStack{
            
            Image("characters")
                .resizable()
                .scaledToFit()
                
            Spacer()
            
            VStack {
                Spacer()
                VStack{
                
                    Text(hubManager.narrativeText[hubManager.actualPage].keys.first ?? "")
                        .foregroundColor(.black)
                        .font(.custom("Prompt-Regular", size: fontSize))
                        .padding(.horizontal, 80)
                        .frame(maxWidth: .infinity)
                    
                        .background{
                            Image("narrativeTextBackground")
                                .resizable()
                                .scaledToFill()
                                .padding(.horizontal, 30) 
                        }
                  
                }
                Spacer()
                        
                }
               
                ZStack{
                   
                    if hubManager.actualPage == 4 {
                        Image("monkeyIcon")
                            .resizable()
                            .scaledToFit()
                            .frame(width: iconSize, height: iconSize)
                            .padding(.horizontal)
                            
                        
                    }
                    
                    
                    if hubManager.actualPage == 5 {
                        Image("frogIcon")
                            .resizable()
                            .scaledToFit()
                            .frame(width: iconSize, height: iconSize)
                            .padding(.horizontal)
                        
                    }
                    
                    if hubManager.actualPage == 6 {
                        Image("bunnyIcon")
                            .resizable()
                            .scaledToFit()
                            .frame(width: iconSize, height: iconSize)
                            .padding(.horizontal)
                        
                    }
                    
                    if hubManager.actualPage == 7 {
                        Image("monkeyIcon")
                            .resizable()
                            .scaledToFit()
                            .frame(width: iconSize, height: iconSize)
                            .padding(.horizontal)
                        
                    }
                    
                    if hubManager.actualPage == 8 {
                        Image("catIcon")
                            .resizable()
                            .scaledToFit()
                            .frame(width: iconSize, height: iconSize)
                            .padding(.horizontal)
                        
                    }
                    
                    if hubManager.actualPage == 9 {
                        Image("monkeyIcon")
                            .resizable()
                            .scaledToFit()
                            .frame(width: iconSize, height: iconSize)
                            .padding(.horizontal)
                        
                    }
                    
                    if hubManager.actualPage == 10 {
                        Image("frogIcon")
                            .resizable()
                            .scaledToFit()
                            .frame(width: iconSize, height: iconSize)
                            .padding(.horizontal)
                        
                    }
                    Spacer()
                }
                    
                    
            ///MARK: TIRAR
                    VStack{
                        Button(action: {
                            if hubManager.actualPage < hubManager.narrativeText.count - 1 {
                                hubManager.actualPage += 1
                            }
                        }) {
                            Text("Próximo")
                                .font(.custom("Prompt-Regular", size: fontSize))
                                .foregroundColor(.blue)
                            
                        }
                    }
            ///MARK: TIRAR

                
                Spacer()
            }
        
            
        }
    }

    
    
    #Preview{
        NarrativeView( )
    }
    
    
    
