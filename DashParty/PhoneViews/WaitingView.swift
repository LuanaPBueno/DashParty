//
//  ConnectInHubView.swift
//  DashParty
//
//  Created by Luana Bueno on 26/03/25.
//

//import Foundation
//import SwiftUI
//
//struct WaitingView: View{
//    
//    var multipeerSession : MPCSession!
//    
//    @State var changed: Bool = HUBPhoneManager.instance.changeScreen
//    @State private var isActive = false
//    @State var navigateHost: Bool = false
//    @State var navigateToPlayerDisplayView: Bool = false
//    
//    
//    var body : some View{
//        
//        NavigationStack{
//            
//            ZStack{
//                
//                Image("purpleBackground")
//                    .resizable()
//                    .scaledToFill()
//                    .ignoresSafeArea()
//                
//                
//                //                    Spacer()
//                //
//                //                    Text("Waiting for players to join...")
//                //                        .multilineTextAlignment(.center)
//                //                        .font(.custom("TorukSC-Regular", size: 40))
//                //                        .foregroundColor(.white)
//                //
//                //                    Spacer()
//                
//                //                    if multipeerSession.host {
//                VStack{
//                    
//                    List(multipeerSession.connectedPeersNames, id: \.self) { player in
//                        Text(player)
//                            .background(
//                                Image("decorativeRectYellow")
//                                    .resizable()
//                                    .scaledToFill()
//                            )
//                        
//                        
//                        
//                        
//                        //                    }
//                        
//                        //                    HStack{
//                        //                    Image("hostPhone")
//                        //                        .resizable()
//                        //                        .scaledToFit()
//                        //                        .frame(width: 200, height: 200)
//                        //
//                        //                }
//                        //  Spacer()
//                        
//                        Button(action: {
//                            // navigate = true
//                            navigateHost = true
//                            HUBPhoneManager.instance.changeScreen = true
//                            
//                        }) {
//                            Image("decorativeRectOrange")
//                                .resizable()
//                                .scaledToFit()
//                                .frame(width: 100, height: 50)
//                                .overlay(
//                                    Text("Continue")
//                                        .font(.custom("TorukSC-Regular", size: 20))
//                                        .foregroundColor(.white)
//                                )
//                        }
//                    }
//                    
//                    NavigationLink(
//                        destination: CharacterView(multipeerSession: multipeerSession),
//                        isActive: $navigateHost,
//                        label: { EmptyView() }
//                    )
//                    
//                    
//                    
//                }
//                .navigationDestination(isPresented: $isActive) {
//                }
//                
//                Spacer()
//                
//                    .onAppear{
//                        if !multipeerSession.host {
//                            navigateToPlayerDisplayView = true
//                        }
//                        
//                    }
//            
//        }
//        .onChange(of: multipeerSession.mcSession.connectedPeers.map { $0.displayName }) {
//            print(multipeerSession.mcSession.connectedPeers.map { $0.displayName })
//        }
//        .navigationDestination(isPresented: $navigateHost) {
//            NarrativePassingView(multipeerSession: multipeerSession)
//        }
//    }
//        .task{
//            print(multipeerSession.host)
//            print(multipeerSession.mcSession.myPeerID)
//        }
//    }
//}
//
//#Preview{
//    WaitingView()
//}
//

import Foundation
import SwiftUI

struct WaitingView: View {
    var multipeerSession: MPCSession!
    
    @State private var navigateHost: Bool = false
    @State private var navigateToPlayerDisplayView: Bool = false
    
    var body: some View {
    
            ZStack {
                Image("purpleBackground")
                    .resizable()
                    .scaledToFill()
                    .ignoresSafeArea()
                
                VStack {
                    Spacer()
                    
                    // Lista de jogadores conectados
                    List(multipeerSession.connectedPeersNames, id: \.self) { player in
                        Text(player)
                            .font(.custom("TorukSC-Regular", size: 24))
                            .foregroundColor(.white)
                            .padding()
                            .background(
                                Image("decorativeRectYellow")
                                    .resizable()
                                    .scaledToFill()
                            )
                            .clipShape(RoundedRectangle(cornerRadius: 8))
                    }
                    .frame(height: 200)
                    .scrollContentBackground(.hidden)
                    .background(Color.clear)
                    
                    Spacer()
                    
                    // Botão "Continue"
                    Button(action: {
                        navigateHost = true
                        HUBPhoneManager.instance.changeScreen = true
                    }) {
                        Image("decorativeRectOrange")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 180, height: 60)
                            .overlay(
                                Text("Continue")
                                    .font(.custom("TorukSC-Regular", size: 24))
                                    .foregroundColor(.white)
                            )
                    }
                    
                    Spacer()
                }
                .padding()
                .onAppear {
                    if !multipeerSession.host {
                        navigateToPlayerDisplayView = true
                    }
                }
            }
            .onChange(of: multipeerSession.mcSession.connectedPeers.map { $0.displayName }) { newValue in
                print("Peers conectados: \(newValue)")
            }
            .navigationDestination(isPresented: $navigateHost) {
                CharacterView(multipeerSession: multipeerSession)
            }
        
        .task {
            print("Host? \(multipeerSession.host)")
            print("Meu PeerID: \(multipeerSession.mcSession.myPeerID)")
        }
    }
}

#Preview {
    WaitingView(multipeerSession: MPCSessionManager.shared)
}
