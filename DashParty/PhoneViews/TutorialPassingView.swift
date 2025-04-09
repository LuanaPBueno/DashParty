//
//  TutorialPassingView.swift
//  DashParty
//
//  Created by Luana Bueno on 26/03/25.
//X

import Foundation

import SwiftUI

struct TutorialPassingView: View {
    var multipeerSession : MPCSession
    var hubManager = HUBPhoneManager.instance
    @State var pass : Bool = false
    
    var currentTutorialImage: [String] = ["tutorialImage1", "tutorialImage2", "tutorialImage3", ""]
    
    var body: some View {
        
             VStack{
                 Text("Press start after reading the tutorial!")
                     .font(.custom("TorukSC-Regular", size: 30))
                     .multilineTextAlignment(.center)

            HStack {
                if currentTutorialImage[safe: hubManager.actualTutorialIndex] == ""{
                    
                    Button {
                        HUBPhoneManager.instance.startMatch = true
                        
                        pass = true
                        
                        DispatchQueue.main.async {
//                            self.hubManager.objectWillChange.send()
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
                
            
            NavigationLink(
                //MARK: TIRAR USERS
               // destination: MatchViewHub(users:  [HUBPhoneManager.instance.user], user:  HUBPhoneManager.instance.user, index: 0, matchManager:  HUBPhoneManager.instance.matchManager),
                destination: matchPhoneView(), 
                isActive: $pass,
                label: { EmptyView() }
            )
            
        }
    }
    
    
    
#Preview {
    
    TutorialPassingView()
}



