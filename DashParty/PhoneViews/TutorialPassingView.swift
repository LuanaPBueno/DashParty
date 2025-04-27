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
            if hubManager.actualTutorialIndex == 5 {
                VStack {
                    Spacer()
                    Button {
                        HUBPhoneManager.instance.startMatch = true
                        router = .game
                        HUBPhoneManager.instance.matchManager.atualizaStart()
                    } label: {
                        Image("startMatchButton")
                            .padding(.bottom, 20)
                    }
                }
            }
            
            // Botões de navegação no rodapé
            if multipeerSession.host{
                VStack{
                    Spacer()
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
                //                VStack {
                //                    Spacer()
                //                    HStack {
                //                        // BACK BUTTON
                //                        Button(action: {
                //                            if hubManager.actualTutorialIndex > 0 {
                //                                hubManager.actualTutorialIndex -= 1
                //                            }
                //                        }) {
                //                            Image("backYellowButton")
                //                                .resizable()
                //                                .frame(width: 40, height: 40)
                //                                .opacity(hubManager.actualTutorialIndex == 0 ? 0.2 : 1.0)
                //                                .disabled(hubManager.actualTutorialIndex == 0)
                //                        }
                //
                //                        Spacer()
                //
                //                        // NEXT BUTTON
                //                        Button(action: {
                //                            if hubManager.actualTutorialIndex < currentTutorialImage.count - 1 {
                //                                hubManager.actualTutorialIndex += 1
                //                            }
                //                        }) {
                //                            Image("nextYellowButton")
                //                                .resizable()
                //                                .frame(width: 40, height: 40)
                //                                .opacity(hubManager.actualTutorialIndex == 5 ? 0.2 : 1.0)
                //                                .disabled(hubManager.actualTutorialIndex == 5)
                //                        }
                //                    }
                //                    .padding(.horizontal, 40)
                //                    .padding(.bottom, 30)
                //                }
            }
        }
        
        
        
        
        
    }
}

#Preview {
    TutorialPassingView(router: .constant(.tutorial), multipeerSession: MPCSessionManager.shared)
}


