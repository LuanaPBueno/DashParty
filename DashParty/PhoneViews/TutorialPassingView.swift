//
//  TutorialPassingView.swift
//  DashParty
//
//  Created by Luana Bueno on 26/03/25.
//

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
    
    var currentTutorialImage: [String] = ["tutorialImage1", "tutorialImage2"]
    
    var body: some View {
        ZStack {
                    Image(currentTutorialImage[safe: hubManager.actualTutorialIndex] ?? "fallbackImage")
                        .resizable()
                        .scaledToFill()
                        .ignoresSafeArea()

                    VStack {
                        Spacer()
                        
                        HStack {
                            // BACK BUTTON
                            Button(action: {
                                if hubManager.actualTutorialIndex > 0 {
                                    hubManager.actualTutorialIndex -= 1
                                }
                            }) {
                                Image("backButton")
                                    .resizable()
                                    .frame(width: 40, height: 40)
                                    .opacity(hubManager.actualTutorialIndex == 0 ? 0.2 : 1.0)
                            }

                            Spacer()

                            // NEXT BUTTON
                            Button(action: {
                                if hubManager.actualTutorialIndex < currentTutorialImage.count - 1 {
                                    hubManager.actualTutorialIndex += 1
                                }
                            }) {
                                Image("nextButton")
                                    .resizable()
                                    .frame(width: 40, height: 40)
                                    .opacity(hubManager.actualTutorialIndex == 1 ? 0.2 : 1.0)
                            }
                        }
                        .padding(.horizontal, 40)
                        .padding(.bottom, 30)

                        // START BUTTON (aparece só na última imagem)
                        if hubManager.actualTutorialIndex == 1 {
                            Spacer()
                            Button(action: {
                                HUBPhoneManager.instance.startMatch = true
                                pass = true
                            }) {
                                Image("startMatchButton")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 100, height: 100)
                            }
                        }
                    }
                }
        .onAppear {
            hubManager.actualTutorialIndex = 0
        }
        

                // NavigationLink sempre presente, ativado via `pass`
                NavigationLink(
                    destination: NarrativePassingView(), // ou matchPhoneView(), se for o correto
                    isActive: $pass,
                    label: { EmptyView() }
                )
            }
}
    
#Preview {
    TutorialPassingView(multipeerSession: MPCSessionManager.shared)
}


