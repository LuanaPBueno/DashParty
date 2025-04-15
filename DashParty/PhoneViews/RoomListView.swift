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
                Button {
                    router = .play
                } label: {
                    Image("backButton")
                }
                if multipeerSession.host {
                    Text("Você é o Host")
                } else {
                    
                    List(multipeerSession.pendingInvitations.keys.sorted(), id: \.self) { peerName in
                        Button(action: {
                            multipeerSession.pendingInvitations[peerName]?(true, multipeerSession.mcSession)
                            if showingInvitationAlert{
                                showingButtonInvitationAlert = true
                            }
                        }) {
                            HStack {
                                Text(peerName)
                                Spacer()
                                Image(systemName: "chevron.right")
                            }
                        }
                    }
                    .navigationTitle("Salas Disponíveis")
                    .scrollContentBackground(.hidden)

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

