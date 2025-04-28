//
//  Untitled.swift
//  DashParty
//
//  Created by Maria Eduarda Mariano on 09/04/25.
//

import Foundation
import SwiftUI
import MultipeerConnectivity

struct RoomListView: View {
    @Binding var router:Router
    
    @ObservedObject var multipeerSession: MPCSession
    @State private var showingInvitationAlert = false
    @State private var invitationToHost: MCPeerID? = nil
    @State private var showingButtonInvitationAlert = false
    @State private var passView: Bool = false
    
    
    var body: some View {
        ZStack{
            Image("purpleBackground")
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()
            
            VStack {
                Button {
                    router = .play
                } label: {
                    Image("backButton")
                        .padding(.leading, 28)
                        .padding(.top, 28)
                }
                if multipeerSession.host {
                    Text("Você é o Host")
                } else {
                    
                    
                    List(multipeerSession.nearbyPeers, id: \.self) { peerID in
                        Button(action: {
                            //print(peerID)
                            invitationToHost = peerID
                            showingButtonInvitationAlert = true
                            
                            
                        }, label: {
                            HStack {
                                Text(peerID.displayName)
                                Spacer()
                                Image(systemName: "chevron.right")
                            }
                        })
                    }
                    .navigationTitle("Salas Disponíveis")
                    .scrollContentBackground(.hidden)
                    
                    
                    .onChange(of: multipeerSession.isConnected){ old, value in
                        if value{
                            router = .waitingRoom
                        }
                    }
                    
                    
//                    List(multipeerSession.pendingInvitations.keys.sorted(), id: \.self) { peerName in
//                        Button(action: {
//                            invitationFromPeer = peerName
//                               if let handler = multipeerSession.pendingInvitations[peerName] {
//                                   multipeerSession.invitationHandler = multipeerSession.pendingInvitations[peerName]
//                                  
//                                   showingButtonInvitationAlert = true
//                               }
//                          
//                        
//                        }) {
//                            HStack {
//                                Text(peerName)
//                                Spacer()
//                                Image(systemName: "chevron.right")
//                            }
//                        }
//                    }
                    

                }
            }
            .alert("Are you sure you want to join?", isPresented: $showingButtonInvitationAlert) {
                Button("Yes") {
                    if let invitationToHost{
                        multipeerSession.invite(peer: invitationToHost)
                    }
                }
                Button("No", role: .cancel) {
                    invitationToHost = nil
                }
            } message: {
                Text("\(invitationToHost?.displayName ?? "") is inviting you to enter the room.")
                    .font(.custom("TorukSC-Regular", size: 24))
                    .foregroundColor(.white)
            }
           
//            .onAppear {
//                multipeerSession.invitationReceivedHandler = { peerName in
////                    invitationFromPeer = peerName
//                    showingInvitationAlert = true
//                }
//                multipeerSession.start()
//            }
        }
    }
}
#Preview {
    RoomListView(router: .constant(.chooseRoom), multipeerSession: MPCSession(service: "kiwi", identity: "uva", maxPeers: 6, matchManager: ChallengeManager()))
}

