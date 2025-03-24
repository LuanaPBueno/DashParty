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
                
                ZStack{
                    Image("narrativeTextBackground")
                        
                    
                    VStack{
                        Text("A cada geração, a floresta Aru escolhe seu líder...")
                        HStack{
                            Spacer()
                            Image("nextNarrativeButton")
                        }
                    }
                }
            }
            
        }
    }
}
