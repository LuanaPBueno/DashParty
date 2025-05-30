//
//  TutorialControllerView.swift
//  DashParty
//
//  Created by Luana Bueno on 26/03/25.
//

import Foundation

import SwiftUI

struct TutorialControllerView: View {
    @Binding var router:Router
    var multipeerSession : MPCSession
    var hubManager = GameInformation.instance
    
    
   
    @State var matchManager = GameInformation.instance.matchManager
   
    
    @State var pass : Bool = false
    
    @State var showStartAlert = false
    var currentTutorialImage: [String] = ["tutorialPhone1", "tutorialPhone2", "tutorialPhone3", "tutorialPhone4", "tutorialPhone5"]
    
    var body: some View {
        ZStack {
            
            Image("backgroundPhone")
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()
                VStack{
                    HStack{
                        Button {
                            router = .storyBoard
                        } label: {
                            Image("backButton")
                                .padding(.leading, 35)
                                .padding(.top, 35)
                        }
                        Spacer()
                    }
                    Spacer()
                }
            

                VStack{
                    Spacer()
                    //Spacer()
                    
                    Text("Heads Up! Things make way more sense after the tutorial.")
                        .multilineTextAlignment(.center)
                        .font(.custom("TorukSC-Regular", size: 30))
                        .padding(40)
                        .foregroundColor(.white)
                    Image("decorativeRectCream")
                        .overlay(
                            HStack {
                                Spacer()
                                Button(action: {
                                    if hubManager.actualTutorialIndex > 0 {
                                        hubManager.actualTutorialIndex -= 1
                                        multipeerSession.broadcastEvent(.tutorialNavigation(currentOffset: hubManager.actualTutorialIndex))
                                    }
                                }) {
                                    Image("backNarrativeButton")
                                        .opacity(hubManager.actualTutorialIndex == 0 ? 0.2 : 1.0)
                                        .disabled(hubManager.actualTutorialIndex == 0)
                                    
                                    
                                    
                                }
                                Spacer()
                                Spacer()
                                Spacer()
                                Spacer()
                                Button(action: {
                                    if hubManager.actualTutorialIndex < currentTutorialImage.count - 1 {
                                        hubManager.actualTutorialIndex += 1
                                        multipeerSession.broadcastEvent(.tutorialNavigation(currentOffset: hubManager.actualTutorialIndex))
                                    } else if hubManager.actualTutorialIndex == currentTutorialImage.count - 1 {
                                        // Quando clicar no último Next → ALERTA
                                        showStartAlert = true
                                    }
                                }) {
                                    Image("passNarrativeButton")
                                        .opacity(hubManager.actualTutorialIndex == 5 ? 0.2 : 1.0)
                                        .disabled(hubManager.actualTutorialIndex == 5)
                                }
                                Spacer()
                            }
                                .padding(.horizontal, 24)
                        )
                    Spacer()
                
                
            }
                
        }
        .alert(isPresented: $showStartAlert) {
            Alert(
                title: Text("Are you ready!"),
                message: Text("As soon as you click start, the game will begin. Are you prepared?"),
                primaryButton: .destructive(Text("Cancel")),
                secondaryButton: .default(Text("Start")) {
                    GameInformation.instance.startMatch = true
                    router = .game
                    GameInformation.instance.matchManager.atualizaStart()
                }
               
            )
        }
    }
    
}

#Preview {
    TutorialControllerView(router: .constant(.tutorial), multipeerSession: MPCSessionManager.shared)
}


