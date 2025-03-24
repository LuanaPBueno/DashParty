//
//  NarrativeView.swift
//  DashParty
//
//  Created by Luana Bueno on 24/03/25.
//

import Foundation
import SwiftUI

struct NarrativeView: View {
    
    var body: some View {
        
        ZStack{
            
            Image("narrativeBackground")
                .resizable()
                .scaledToFill()
                .edgesIgnoringSafeArea(.all)
            
            
            VStack{
                Image("narrativeSkipButton")
                    .frame(width: 100, height: 100)
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topTrailing)
                    .padding(.top, 20)
                    .padding(.trailing, 40)
                
                VStack{
                                    
                    ZStack{
                        Image("narrativeTextBackground")
                            .padding(.bottom, 350)
                            .frame(maxWidth: 1280)
                            
                        VStack {
                            Text("A cada geração, a floresta Aru escolhe seu líder...")
                                .foregroundColor(.black)
                                .foregroundColor(.black)
                                .font(.custom("Prompt-Regular", size: 45))
                                .font(.system(size: 22, weight: .medium))
                                .multilineTextAlignment(.center)
                                .padding(.bottom, 30)
                            
                            HStack{
                                Spacer()
                                Image("nextNarrativeButton")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(maxWidth: 50)
                                    .padding(.trailing, 100)
                                    .padding(.bottom, 300)
                            }
                        }
                    }
                }
            }
        }
    }
}

#Preview{
    NarrativeView()
}
