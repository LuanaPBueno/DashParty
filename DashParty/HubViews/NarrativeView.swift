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
        return UIScreen.main.bounds.width * 0.03
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
                    .font(.custom("Prompt-Regular", size: fontSize ))
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
    }
    
    private func withoutCharacter() -> some View {
        VStack {
            //mark: APAGAR ISSO
            Button {
                hubManager.actualPage += 1
            } label: {
                
                Text("passa a tela")
            }
            //mark: APAGAR ISSO
            ZStack {
                Image("narrativeTextBackground")
                    .resizable()
                    .scaledToFit()
                    .padding(.horizontal, 30)
                
                
                VStack {
                    Text(hubManager.narrativeText[hubManager.actualPage].keys.first ?? "")
                        .foregroundColor(.black)
                        .font(.custom("Prompt-Regular", size: fontSize))
                        .multilineTextAlignment(.center)
                        .frame(maxWidth: 1000)
                }
                
                
            }
        }
    }
    
    private func withCharacter() -> some View {
        VStack {
            Spacer().frame(height: 40)
            
            //mark: APAGAR ISSO
            Button {
                hubManager.actualPage += 1
            } label: {
                
                Text("passa a tela")
            }
            //mark: APAGAR ISSO
            ZStack{
                
                Image("characters")
                    .resizable()
                    .scaledToFit()
                    .padding(.horizontal, 30)
                    .padding(.bottom, 400)
            
                    ZStack{
                        Image("narrativeTextBackground")
                            .resizable()
                            .scaledToFit()
                            .padding(.horizontal, 30)
                        
                        if hubManager.actualPage == 4 {
                            Image("monkeyIcon")
                                .resizable()
                                .scaledToFit()
                                .frame(maxWidth: 80)
                                .padding(.bottom, 200)
                                .padding(.horizontal)
                            
                        }
                        
                        if hubManager.actualPage == 5 {
                            Image("frogIcon")
                                .resizable()
                                .scaledToFit()
                                .frame(maxWidth: 80)
                                .padding(.bottom, 200)
                                .padding(.horizontal)
                            
                        }
                        
                        if hubManager.actualPage == 6 {
                            Image("bunnyIcon")
                                .resizable()
                                .scaledToFit()
                                .frame(maxWidth: 80)
                                .padding(.bottom, 200)
                                .padding(.horizontal)
                            
                        }
                        
                        if hubManager.actualPage == 7 {
                            Image("monkeyIcon")
                                .resizable()
                                .scaledToFit()
                                .frame(maxWidth: 80)
                                .padding(.bottom, 200)
                                .padding(.horizontal)
                            
                        }
                        
                        if hubManager.actualPage == 8 {
                            Image("catIcon")
                                .resizable()
                                .scaledToFit()
                                .frame(maxWidth: 80)
                                .padding(.bottom, 200)
                                .padding(.horizontal)
                            
                        }
                        
                        if hubManager.actualPage == 9 {
                            Image("monkeyIcon")
                                .resizable()
                                .scaledToFit()
                                .frame(maxWidth: 80)
                                .padding(.bottom, 200)
                                .padding(.horizontal)
                            
                        }
                        
                        if hubManager.actualPage == 10 {
                            Image("frogIcon")
                                .resizable()
                                .scaledToFit()
                                .frame(maxWidth: 80)
                                .padding(.bottom, 200)
                                .padding(.horizontal)
                            
                        }
                            
                        VStack {
                            Text(hubManager.narrativeText[hubManager.actualPage].keys.first ?? "")
                                .foregroundColor(.black)
                                .font(.custom("Prompt-Regular", size: fontSize))
                                .multilineTextAlignment(.center)
                                .frame(maxWidth: 1000)
                        }
                        Spacer()
                    }
                    
                }
            }
        }
    }



#Preview{
    NarrativeView()
}



