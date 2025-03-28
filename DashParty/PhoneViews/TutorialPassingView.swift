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
    
    var currentTutorialImage: [String] = ["tutorialImage1", "tutorialImage2", "tutorialImage3", ""]
    
    var body: some View {
        
        ZStack{
             VStack{
                 Text("PRESS START AFTER READING THE TUTORIAL!")
                     .fontWeight(.bold)
                     .font(.title)
            HStack {
                if currentTutorialImage[safe: hubManager.actualTutorialIndex] == ""{
                    
                    Button {
                        HUBPhoneManager.instance.startMatch = true
                        
                        pass = true
                        
                        DispatchQueue.main.async {
                            self.hubManager.objectWillChange.send()
                        }
                        
                    } label: {
                        Image("startMatchButton")
                        
                    }
                }else{
                    Image(currentTutorialImage[safe: hubManager.actualTutorialIndex] ?? "fallbackImage")
                        .resizable()
                        .scaledToFit()
                        .edgesIgnoringSafeArea(.all)
                }
                
                HStack {
                    if currentTutorialImage[safe: hubManager.actualTutorialIndex] != ""{
                        
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
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background {
                    Image("greenBackground")
                        .resizable()
                        .scaledToFill()
                        .edgesIgnoringSafeArea(.all)
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

#Preview{
 TutorialPassingView( )
}
