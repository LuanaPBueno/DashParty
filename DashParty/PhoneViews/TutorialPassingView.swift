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
    @State var pass : Bool = false
    
    var currentTutorialImage: [String] = ["tutorialImage1", "tutorialImage2", "tutorialImage3", "tutorialToStart"]
    
    var body: some View {
        ZStack {
            Image(currentTutorialImage[safe: hubManager.actualTutorialIndex] ?? "fallbackImage")
                .resizable()
                .scaledToFill()
                .edgesIgnoringSafeArea(.all)
            
            HStack {
                if currentTutorialImage[safe: hubManager.actualTutorialIndex] != "tutorialToStart"{
                    Spacer()
                    Button(action: {
                        self.hubManager.actualTutorialIndex += 1
                    }) {
                        Image("passNarrativeButton")
                            .resizable()
                            .frame(width: 40, height: 40)
                    }
                    .padding()
                }else{
                    Button {
                        HUBPhoneManager.instance.startMatch = true
                        
                        pass = true
                        
                        DispatchQueue.main.async {
                                self.hubManager.objectWillChange.send()
                            }
                    } label: {
                        Image("startMatchButton")
                    }
                    
                    

                }
            }
        }
        
        NavigationLink(
            destination: matchPhoneView(),
            isActive: $pass,
            label: { EmptyView() }
        )
        
    }
}



struct matchPhoneView : View{
    var body : some View{
        Image("matchPhoneViewBackground")
    }
}
