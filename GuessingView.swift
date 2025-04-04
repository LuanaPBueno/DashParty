//
//  GuessingView.swift
//  DashParty
//
//  Created by Luana Bueno on 31/03/25.
//

import SwiftUI
import SwiftUI
import SwiftUI

import SwiftUI
struct RoomView: View {
    //MARK: Deixar observable
    @State var t = false
    var multipeerSession: MPCSession
    @State var navigateHost: Bool = false
    @State var navigateToPlayerDisplayView: Bool = false

    var body: some View {
        VStack {
           
            if multipeerSession.host {
                Button {
                    t.toggle()
                } label: {
                    Text("atualizar")
                }
            }
            
            if multipeerSession.host {
                VStack{
                Text("Im host")
                Text("Jogadores conectados:")
                    .font(.headline)
                    List(multipeerSession.mcSession.connectedPeers.map { $0.displayName }, id: \.self) { player in
                        Text(player)
                        
                    }
                    Button {
                        self.navigateHost = true
                    } label: {
                        Text("Start Tutorial")
                    }

                }
            }
           
        }
        .task{
            if !multipeerSession.host {
                navigateToPlayerDisplayView = true
            }
        }
        .navigationDestination(isPresented: $navigateHost, destination: {
            ConnectInHubView(multipeerSession: multipeerSession)
        })
//        .navigationDestination(isPresented: $navigateToPlayerDisplayView, destination: {
//            ConnectInHubView()
//        })
        .onChange(of: multipeerSession.mcSession.connectedPeers.map { $0.displayName }) {
            print(multipeerSession.mcSession.connectedPeers.map { $0.displayName })
        }
        .task{
            print(multipeerSession.host)
            print(multipeerSession.mcSession.myPeerID)
        }
    }
}
struct InvitationListView: View {
    @Environment(MPCSession.self) private var mpcSession
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        NavigationStack {
            List(Array(mpcSession.pendingInvitations.keys), id: \.self) { peerName in
                HStack {
                    Text(peerName) // Usando diretamente o nome do peer (String)
                    Spacer()
                    Button("Entrar") {
                        if let handler = mpcSession.pendingInvitations[peerName] {
                            handler(true, mpcSession.mcSession)
                        }
                        dismiss()
                    }
                }
            }
            .navigationTitle("Salas Disponíveis")
            .toolbar {
                Button("Cancelar") { dismiss() }
            }
        }
    }
}

struct RoomListView: View {
    @ObservedObject var multipeerSession: MPCSession
    @State private var showingInvitationAlert = false
    @State private var invitationFromPeer = ""
    
    var body: some View {
        VStack {
            if multipeerSession.host {
                Text("Você é o Host")
                // ... conteúdo do host
            } else {
                List(multipeerSession.pendingInvitations.keys.sorted(), id: \.self) { peerName in
                    Button(action: {
                        multipeerSession.pendingInvitations[peerName]?(true, multipeerSession.mcSession)
                    }) {
                        HStack {
                            Text(peerName)
                            Spacer()
                            Image(systemName: "chevron.right")
                        }
                    }
                }
                .navigationTitle("Salas Disponíveis")
            }
        }
        .alert("Convite Recebido", isPresented: $showingInvitationAlert) {
            Button("Aceitar") {
                multipeerSession.acceptInvitation()
            }
            Button("Recusar", role: .cancel) {
                multipeerSession.rejectInvitation()
            }
        } message: {
            Text("\(invitationFromPeer) está te convidando para entrar na sala.")
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
