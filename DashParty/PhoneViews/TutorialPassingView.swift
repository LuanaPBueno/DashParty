//
//  TutorialPassingView.swift
//  DashParty
//
//  Created by Luana Bueno on 26/03/25.
//

import Foundation

import SwiftUI

struct TutorialPassingView: View {
    @ObservedObject var hubManager = HUBPhoneManager.instance
    
    var currentTutorialImage: [String] = ["tutorialImage1", "tutorialImage2", "tutorialImage3"]
    
    var body: some View {
        ZStack {
            Image(currentTutorialImage[safe: hubManager.actualTutorialIndex] ?? "fallbackImage")
                .resizable()
                .scaledToFill()
                .edgesIgnoringSafeArea(.all)
            
            HStack {
                Spacer()
                Button(action: {
                    self.hubManager.actualTutorialIndex += 1
                }) {
                    Image("passNarrativeButton")
                        .resizable()
                        .frame(width: 40, height: 40)
                }
                .padding()
            }
        }
        
    }
}


