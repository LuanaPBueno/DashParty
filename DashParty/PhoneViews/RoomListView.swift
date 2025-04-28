//
//  Untitled.swift
//  DashParty
//
//  Created by Maria Eduarda Mariano on 09/04/25.
//

import Foundation
import SwiftUI

struct RoomListView: View {
    @Binding var router:Router
    
    @ObservedObject var multipeerSession: MPCSession
    @State private var showingInvitationAlert = false
    @State private var invitationFromPeer = ""
    @State private var showingButtonInvitationAlert = false
    @State private var passView: Bool = false
    
    var body: some View {
        ZStack{
            Image("purpleBackground")
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()
            
            VStack {
                HStack {
                    Button {
                        router = .play
                    } label: {
                        Image("backButton")
                        
                    }
                    .padding(.leading, 16)
                    Spacer()
                }
                .padding(.leading, 35)
                .padding(.top, 35)
                
                if multipeerSession.host {
                    Text("Você é o Host")
                } else {
                    Spacer()
                    ZStack {
                        Image("roomRect")
                        // .resizable()
                        //.aspectRatio(contentMode: .fit)
                            .overlay(
                                ScrollView {
                                    VStack(spacing: 20) {
                                        //Spacer()
                                        ForEach(multipeerSession.pendingInvitations.keys.sorted(), id: \.self) { peerName in
                                            HStack(spacing: 20) {
                                                //                                                Spacer()
                                                Text(peerName)
                                                    .font(.custom("TorukSC-Regular", size: 32))
                                                    .foregroundColor(.black)
                                                
                                                Spacer()
                                                Button(action: {
                                                    multipeerSession.pendingInvitations[peerName]?(true, multipeerSession.mcSession)
                                                    if showingInvitationAlert {
                                                        showingButtonInvitationAlert = true
                                                    }
                                                }) {
                                                    OrangeButtonPhone(text: "Join", sizeFont: 20)
                                                    
                                                }
                                                .frame(width: 100)
                                                //.buttonStyle(PlainButtonStyle()) // Importantíssimo para não estourar a área clicável
                                                //                                                Spacer()
                                            }
                                            //.frame(maxWidth: .infinity)
                                            //.contentShape(Rectangle()) // só o necessário é clicável
                                            .padding(.horizontal, 100) // Distância do texto para as bordas
                                        }
                                        //Spacer()
                                    }
                                    .padding(.vertical, 20)
                                }
                            )
                    }
                    //.padding(.horizontal, 30)
                    //.padding(.horizontal, 30)
                    Spacer()
                    
                    
                }
            }
            .alert("Are you sure you want to join?", isPresented: $showingButtonInvitationAlert) {
                Button("Yes") {
                    multipeerSession.acceptInvitation()
                    router = .waitingRoom
                }
                Button("No", role: .cancel) {
                    multipeerSession.rejectInvitation()
                }
            } message: {
                Text("\(invitationFromPeer) is inviting you to enter the room.")
                    .font(.custom("TorukSC-Regular", size: 24))
                    .foregroundColor(.white)
            }
            
            .onAppear {
                multipeerSession.invitationReceivedHandler = { peerName in
                    invitationFromPeer = peerName
                    showingInvitationAlert = true
                }
                multipeerSession.start()
            }
        }
    }
}
#Preview {
    RoomListView(router: .constant(.chooseRoom), multipeerSession: MPCSession(service: "kiwi", identity: "uva", maxPeers: 6, matchManager: ChallengeManager()))
}

