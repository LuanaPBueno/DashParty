//
//  Untitled.swift
//  DashParty
//
//  Created by Maria Eduarda Mariano on 09/04/25.
//

import Foundation
import SwiftUI
import MultipeerConnectivity

struct RoomSelectionView: View {
    @Binding var router:Router
    
    @ObservedObject var multipeerSession: MPCSession
    @State private var showingInvitationAlert = false
    @State private var invitationToHost: MCPeerID? = nil
    @State private var showingButtonInvitationAlert = false
    @State private var passView: Bool = false
    
    
    var body: some View {
        ZStack{
            Image("backgroundPhone")
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()
            
            VStack{
                HStack {
                    Button {
                        router = .play
                    } label: {
                        Image("backButton")
                        
                    }
                    Spacer()
                }
                .padding(.leading, 35)
                .padding(.top, 35)
                Spacer()
            }
            VStack {
                
                
                if multipeerSession.host {
                    Text("Você é o Host")
                } else {
                    
                    //Spacer()
                    Text("Rooms")
                        .font(.custom("TorukSC-Regular", size: 40))
                        .foregroundStyle(.white)
                    ZStack{
                        Image("roomRect")
                            .overlay{
                                ScrollView {
                                    VStack(spacing: 20) {
                                        ForEach(multipeerSession.nearbyPeers, id: \.self) { peerID in
                                            
                                            HStack(spacing: 20) {
                                                Text(peerID.displayName)
                                                    .font(.custom("TorukSC-Regular", size: 32))
                                                    .foregroundColor(.black)
                                                
                                                Spacer()
                                                Button(action: {
                                                    invitationToHost = peerID
                                                    showingButtonInvitationAlert = true
                                                }) {
                                                    OrangeButtonLabel(text: "Join", sizeFont: 20)
                                                    
                                                }
                                                .frame(width: 100)
                                            }
                                            .padding(.horizontal, 100)
                                        }
                                        
//                                        List(multipeerSession.nearbyPeers, id: \.self) { peerID in
//                                            Button(action: {
//                                                //print(peerID)
//                                                invitationToHost = peerID
//                                                showingButtonInvitationAlert = true
//                                                
//                                                
//                                            }, label: {
//                                                HStack {
//                                                    Text(peerID.displayName)
//                                                    Spacer()
//                                                    Image(systemName: "chevron.right")
//                                                }
//                                            })
//                                        }
//                                        .navigationTitle("Salas Disponíveis")
//                                        .scrollContentBackground(.hidden)
                                    }
                                    .padding(.vertical, 20)
                                }
                                
                            }
                        Spacer()

                    }
                    
                    
                    
                    .onChange(of: multipeerSession.isConnected){ old, value in
                        if value{
                            router = .waitingRoom
                        }
                    }
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
        }
    }
}
#Preview {
    RoomSelectionView(router: .constant(.chooseRoom), multipeerSession: MPCSession(service: "kiwi", identity: "uva", maxPeers: 6, matchManager: MatchManager()))
}

