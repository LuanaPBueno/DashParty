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
    @State private var navigate: Bool = false
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
                
                ZStack{
                    Image("decorativeRectCream")
                    
                    HStack {
                        
                        Spacer()
                        
                        Button {
                            if hubManager.actualPage > 0 {
                                hubManager.actualPage -= 1
                            }
                        } label: {
                            Image("backNarrativeButton")
                        }
                        Spacer()
                        Button {
                            if hubManager.actualPage < hubManager.narrativeText.count - 1 {
                                hubManager.actualPage += 1
                            } else {
                                navigate = true
                                router = .tutorial
                                
                                //                                DispatchQueue.main.async {
                                //                                    //                                    self.hubManager.objectWillChange.send()
                                //                                }
                            }
                        } label: {
                            Image("passNarrativeButton")
                        }
                        Spacer()
                    }
                }
                
                Spacer()
                
                Button {
                    hubManager.actualPage = hubManager.narrativeText.count - 1
                 //   navigate = true
                    router = .tutorial
                    
                    //                        DispatchQueue.main.async {
                    //                            //                                self.hubManager.objectWillChange.send()
                    //                        }
                    
                    
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
