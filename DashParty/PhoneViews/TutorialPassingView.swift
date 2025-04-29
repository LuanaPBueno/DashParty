//
//  TutorialPassingView.swift
//  DashParty
//
//  Created by Luana Bueno on 26/03/25.
//

import Foundation

import SwiftUI

struct TutorialPassingView: View {
    @Binding var router:Router
    var multipeerSession : MPCSession
    var hubManager = HUBPhoneManager.instance
    
    
    //MARK: TIRAR
    let user = HUBPhoneManager.instance.user
    @State var matchManager = HUBPhoneManager.instance.matchManager
    var users: [User] = [User(name: "A"), User(name: "B")]
    //MARK: TIRAR
    
    @State var pass : Bool = false
    
    @State var showStartAlert = false
    var currentTutorialImage: [String] = ["tutorialPhone1", "tutorialPhone2", "tutorialPhone3", "tutorialPhone4", "tutorialPhone5", "tutorialPhone6"]
    
    var body: some View {
        ZStack {
            
            Image("purpleBackground")
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()
            if !multipeerSession.host{
                Image("eyesOnTheHub")
                    .resizable()
                    .scaledToFill()
                    .ignoresSafeArea()
            }
            if multipeerSession.host{
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
            }

            if multipeerSession.host{
                VStack{
                    Spacer()
                    //Spacer()
                    
                    Text("Look at the screen and enjoy the story!")
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
                
        }
        .alert(isPresented: $showStartAlert) {
            Alert(
                title: Text("Are you ready!"),
                message: Text("As soon as you click start, the game will begin. Are you prepared?"),
                primaryButton: .destructive(Text("Cancel")),
                secondaryButton: .default(Text("Start")) {
                    HUBPhoneManager.instance.startMatch = true
                    router = .game
                    HUBPhoneManager.instance.matchManager.atualizaStart()
                }
               
            )
        }
    }
    
}

#Preview {
    TutorialPassingView(router: .constant(.tutorial), multipeerSession: MPCSessionManager.shared)
}


