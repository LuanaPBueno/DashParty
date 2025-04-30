//
//  ConnectInHubView.swift
//  DashParty
//
//  Created by Luana Bueno on 26/03/25.
//


import Foundation
import SwiftUI

struct WaitingView: View {
    @Binding var router: Router
    var multipeerSession: MPCSession
    
    @State private var navigateToPlayerDisplayView: Bool = false
    
    var body: some View {
        ZStack {
            Image("purpleBackground")
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()
            
            VStack {
                // TOPO: Botão de voltar à esquerda + Nome da sala centralizado
                ZStack {
                    HStack {
                        Button {
                            router = .start
                        } label: {
                            Image("backButton")
                        }
                        .padding(.leading, 35)
                        .padding(.top, 35)
                        
                        Spacer()
                    }
                    
                    Text(multipeerSession.hostPeerID?.displayName ?? "")
                        .font(.custom("TorukSC-Regular", size: 34, relativeTo: .title))
                        .multilineTextAlignment(.center)
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding(.top, 35)
                }
                .padding(.horizontal, 20)
                
                // Espaço de 134 até os MMPhones
                Spacer()
                Spacer()
                Spacer()
                Spacer()
                Spacer()
                Spacer()
                Spacer()
                
                // MMPhones
                HStack(spacing: 20) {
                    MMPhone(playerName: multipeerSession.hostName, sizePadding: 0)
                    MMPhone(playerName: HUBPhoneManager.instance.playername, sizePadding: 0)
                    ForEach(multipeerSession.connectedPeersNames, id: \.self) { player in
                        if player != multipeerSession.hostPeerID?.displayName {
                            MMPhone(playerName: player, sizePadding: 0)
                        }
                    }
                }
                .frame(height: UIScreen.main.bounds.height * 0.55)
                .padding(.horizontal)
                
                // Espaço de 100 até o final da tela
                Spacer()
                //Spacer()
                //Spacer()
                    //.frame(height: 100)
            }
            .onAppear {
                if !multipeerSession.host {
                    navigateToPlayerDisplayView = true
                }
            }
        }
        .onChange(of: multipeerSession.mcSession.connectedPeers.map { $0.displayName }) { newValue in
            print("Peers conectados: \(newValue)")
        }
        .task {
            print("Host? \(multipeerSession.host)")
            print("Meu PeerID: \(multipeerSession.mcSession.myPeerID)")
        }
    }
}




#Preview {
    WaitingView(router: .constant(.waitingRoom), multipeerSession: MPCSessionManager.shared)
}
