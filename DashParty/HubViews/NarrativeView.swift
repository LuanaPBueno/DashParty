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
                    .background(Color(.white))
                    .frame(width: 100, height: 100)
                
                ZStack{
                    Image("narrativeTextBackground")
                    
                    VStack{
                        Text("A cada geração, a floresta Aru escolhe seu líder...")
                            .foregroundColor(.black)
                        HStack{
                            Spacer()
                            Image("nextNarrativeButton")
                                .background(Color(.white))
                                .frame(width: 100, height: 100)
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
