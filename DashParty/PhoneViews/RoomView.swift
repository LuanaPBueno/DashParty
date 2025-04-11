//
//  GuessingView.swift
//  DashParty
//
//  Created by Luana Bueno on 31/03/25.
//

import SwiftUI

struct RoomView: View {
    //MARK: Deixar observable
    @Binding var router:Router
    @ObservedObject var multipeerSession: MPCSession
    @State var navigateHost: Bool = false
    @State var navigateToPlayerDisplayView: Bool = false

    var body: some View {
        ZStack{
            Image("purpleBackground")
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()
            
            VStack {
                if multipeerSession.host {
                    VStack{
                        Text("Im host")
                        Text("Jogadores conectados:")
                            .font(.custom("TorukSC-Regular", size: 24))
                        List(multipeerSession.connectedPeersNames, id: \.self) { player in
                            Text(player)
                        }
                        Button {
                            router = .storyBoard
                        } label: {
                            Text("Start Tutorial")
                                .font(.custom("TorukSC-Regular", size: 24))
                        }
                        
                    }
                }
                
            }
        }
        .scrollContentBackground(.hidden)

        .task{
            if !multipeerSession.host {
                navigateToPlayerDisplayView = true
            }
        }
        .navigationDestination(isPresented: $navigateHost, destination: {
            WaitingView(multipeerSession: multipeerSession)
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

#Preview {
    RoomView(router: .constant(.matchmaking), multipeerSession: MPCSession(service: "banana", identity: "maça", maxPeers: 5, matchManager: ChallengeManager()))
}
//struct InvitationListView: View {
//    @Environment(MPCSession.self) private var mpcSession
//    @Environment(\.dismiss) private var dismiss
//    @State var passView: Bool = false
//    
//    var body: some View {
//        NavigationStack {
//            List(Array(mpcSession.pendingInvitations.keys), id: \.self) { peerName in
//                HStack {
//                    Text(peerName) // Usando diretamente o nome do peer (String)
//                    Spacer()
//                    Button("Entrar") {
//                        if let handler = mpcSession.pendingInvitations[peerName] {
//                            handler(true, mpcSession.mcSession)
//                        }
////                        passView = true
//                        dismiss()
//                    }
//                }
//            }
//            .navigationTitle("Salas Disponíveis")
//            .toolbar {
//                Button("Cancelar") { dismiss() }
//            }
//        }
//        
//        NavigationLink(
//            destination: NarrativePassingView(),
//            isActive: $passView,
//            label: { EmptyView() }
//        )
//    }
//}

//struct RoomListView: View {
//    @ObservedObject var multipeerSession: MPCSession
//    @State private var showingInvitationAlert = false
//    @State private var invitationFromPeer = ""
//    @State private var showingButtonInvitationAlert = false
//    @State private var passView: Bool = false
//    
//    var body: some View {
//        VStack {
//            if multipeerSession.host {
//                Text("Você é o Host")
//            } else {
//                List(multipeerSession.pendingInvitations.keys.sorted(), id: \.self) { peerName in
//                    Button(action: {
//                        multipeerSession.pendingInvitations[peerName]?(true, multipeerSession.mcSession)
//                        if showingInvitationAlert{
//                            showingButtonInvitationAlert = true
//                        }
//                    }) {
//                        HStack {
//                            Text(peerName)
//                            Spacer()
//                            Image(systemName: "chevron.right")
//                        }
//                    }
//                }
//                .navigationTitle("Salas Disponíveis")
//            }
//        }
//        .alert("Convite Recebido", isPresented: $showingButtonInvitationAlert) {
//            Button("Aceitar") {
//                multipeerSession.acceptInvitation()
//                passView = true
//            }
//            Button("Recusar", role: .cancel) {
//                multipeerSession.rejectInvitation()
//            }
//        } message: {
//            Text("\(invitationFromPeer) está te convidando para entrar na sala.")
//        }
//        .navigationDestination(isPresented: $passView){
//            CharacterView(multipeerSession: multipeerSession)
//        }
//        .onAppear {
//            multipeerSession.invitationReceivedHandler = { peerName in
//                invitationFromPeer = peerName
//                showingInvitationAlert = true
//            }
//            multipeerSession.start()
//        }
//    }
//}
//
//#Preview {
//    RoomListView(multipeerSession: multipeerSession)
//}
//
