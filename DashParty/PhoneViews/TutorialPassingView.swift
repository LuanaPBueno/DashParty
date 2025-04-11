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
    
    //MARK: TIRAR
    let user = HUBPhoneManager.instance.user
    @State var matchManager = HUBPhoneManager.instance.matchManager
    var users: [User] = [User(name: "A"), User(name: "B")]
    //MARK: TIRAR
    
    @State var pass : Bool = false
    
    var currentTutorialImage: [String] = ["tutorialImage1", "tutorialImage2", "tutorialImage3", ""]
    
    var body: some View {
        ZStack{
            Image("purpleBackground")
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()
            
            VStack{
                Spacer()
                
                Text("Press start after reading the tutorial!")
                    .font(.custom("TorukSC-Regular", size: 30))
                    .foregroundColor(.white)
                    .multilineTextAlignment(.center)
                
                
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
                        HStack{
                            Spacer()
                            Image(currentTutorialImage[safe: hubManager.actualTutorialIndex] ?? "fallbackImage")
                                .resizable()
                                .scaledToFit()
                            Spacer()
                        }
                    }
                    
                    Spacer()
                
                        if currentTutorialImage[safe: hubManager.actualTutorialIndex] != ""{
                            
                            Button(action: {
                                self.hubManager.actualTutorialIndex += 1
                            }) {
                                Image("passNarrativeButton")
                                    .resizable()
                                    .frame(width: 40, height: 40)
                            
                            
                        }
                    }
                
            }
            
            
            NavigationLink(
                //MARK: TIRAR USERS
                destination: matchPhoneView(),
                isActive: $pass,
                label: { EmptyView() }
            )
            
        }
    }
}
    
#Preview {
    TutorialPassingView(multipeerSession: MPCSessionManager.shared)
}


