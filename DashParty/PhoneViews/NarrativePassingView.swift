//
//  narrativePassingView.swift
//  DashParty
//
//  Created by Luana Bueno on 26/03/25.
//

import Foundation
import SwiftUI

struct NarrativePassingView: View {
    @Binding var router:Router
    var multipeerSession : MPCSession = MPCSessionManager.shared
    
    //    var multipeerSession : MPCSession!
    var hubManager = HUBPhoneManager.instance
    //    @State private var navigate: Bool = false
    @State private var isActive = false
    
    var body: some View {
        ZStack{
            Image("blurForest")
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()
            
            VStack {
                
                Spacer()
                
                Text("FOLLOW THE STORY ON THE BIG SCREEN!")
                    .multilineTextAlignment(.center)
                    .font(.custom("TorukSC-Regular", size: 30))
                    .padding(40)
                    .foregroundColor(.white)
                Image("decorativeRectCream")
                //.resizable()
                //.scaledToFit()
                //.frame(maxWidth: 350) // ajuste conforme o tamanho do seu rect
                    .overlay(
                        HStack {
                            Spacer()
                            Button(action: {
                                if hubManager.actualPage > 0 {
                                    hubManager.actualPage -= 1
                                }
                                else {
                                    print("entrou aq no else no back ")
                                    router = .matchmaking
                                }
                            }) {
                                Image("backNarrativeButton")
                                
                                //.resizable()
                                //.frame(width: 40, height: 40)
                                // .opacity(hubManager.actualPage == 0 ? 0.2 : 1.0)
                                
                            }
                            // .disabled(hubManager.actualPage == 0)
                            
                            Spacer()
                            Spacer()
                            Spacer()
                            Spacer()
                            
                            Button(action: {
                                if hubManager.actualPage < hubManager.narrativeText.count - 1 {
                                    hubManager.actualPage += 1
                                } else {
                                    print("entrou aqui no pass")
                                    router = .tutorial
                                }
                            }) {
                                Image("passNarrativeButton")
                                
                                //.opacity(hubManager.actualPage == hubManager.narrativeText.count - 1 ? 0.2 : 1.0)
                            }
                            //.disabled(hubManager.actualPage == hubManager.narrativeText.count - 1)
                            Spacer()
                        }
                            .padding(.horizontal, 24)
                    )
                Spacer()
                
                Button {
                    hubManager.actualPage = hubManager.narrativeText.count - 1
                    //   navigate = true
                    router = .tutorial
                    
                } label: {
                    Image("skip")
                }
                
                
                Spacer()
            }
            .task{
                HUBPhoneManager.instance.users = HUBPhoneManager.instance.allPlayers.map { player in
                    return User(
                        id: player.id,
                        name: ""
                    )
                }
            }
            
            
            
        }
    }
}

#Preview {
    NarrativePassingView(router: .constant(.storyBoard))
}
