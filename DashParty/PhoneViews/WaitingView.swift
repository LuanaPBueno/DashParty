//
//  ConnectInHubView.swift
//  DashParty
//
//  Created by Luana Bueno on 26/03/25.
//

import Foundation
import SwiftUI

struct WaitingView: View{
    
    var multipeerSession : MPCSession!
    @State var navigate : Bool = false
    @State var changed: Bool = HUBPhoneManager.instance.changeScreen
    @State private var isActive = false
    @State var navigateHost: Bool = false
    @State var navigateToPlayerDisplayView: Bool = false
    
    
    var body : some View{
        
        NavigationStack{
            ZStack{
                Image("purpleBackground")
                    .resizable()
                    .scaledToFill()
                    .ignoresSafeArea()
            
                VStack{
//                    Spacer()
//                    
//                    Text("Waiting for players to join...")
//                        .multilineTextAlignment(.center)
//                        .font(.custom("TorukSC-Regular", size: 40))
//                        .foregroundColor(.white)
//                    
//                    Spacer()
                    
                    if multipeerSession.host {
                        VStack{

                            List(multipeerSession.connectedPeersNames, id: \.self) { player in
                                                   Text(player)
                                               }
                            .background(Color .white)

                        }
                    }
                    
//                    HStack{
//                    Image("hostPhone")
//                        .resizable()
//                        .scaledToFit()
//                        .frame(width: 200, height: 200)
//                    
//                }
                  //  Spacer()
                    
                  Button(action: {
                       // navigate = true
                        self.navigateHost = true
                        HUBPhoneManager.instance.changeScreen = true
                      
                    }) {
                        Image("decorativeRectOrange")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 100, height: 50)
                            .overlay(
                                Text("Continue")
                                    .font(.custom("TorukSC-Regular", size: 20))
                                    .foregroundColor(.white)
                            )
                    }
                    

                    NavigationLink(
                        destination: CharacterView(multipeerSession: multipeerSession),
                        isActive: $navigate,
                        label: { EmptyView() }
                    )
                    
             
                    
                }
                .navigationDestination(isPresented: $isActive) {
                }
                
                Spacer()
            }
            .task{
                if !multipeerSession.host {
                    navigateToPlayerDisplayView = true
                }
            
            }
        }
        .onChange(of: multipeerSession.mcSession.connectedPeers.map { $0.displayName }) {
            print(multipeerSession.mcSession.connectedPeers.map { $0.displayName })
        }
        .navigationDestination(isPresented: $navigateHost, destination: {
            NarrativePassingView(multipeerSession: multipeerSession)
        })
        .task{
            print(multipeerSession.host)
            print(multipeerSession.mcSession.myPeerID)
        }
    }
}

#Preview{
    WaitingView( )
}

