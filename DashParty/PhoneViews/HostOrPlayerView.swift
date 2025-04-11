//
//  Untitled.swift
//  DashParty
//
//  Created by Maria Eduarda Mariano on 08/04/25.
//

import SwiftUI
import CoreMotion

struct HostOrPlayerView: View {
    @Binding var router:Router
    var multipeerSession : MPCSession = MPCSessionManager.shared
    
    @State var navigateToHost : Bool = false
//    @State var navigateToJoin : Bool = false
    @State var changed: Bool = HUBPhoneManager.instance.changeScreen
    @State private var isActive = false
    @State var showAlert = false
    @State var showRoomAlert = false
    @State var userName: String = ""
    @State var roomName: String = ""
    
    var body: some View {
        
       
            
            ZStack{
                Image("darkblueBackground")
                    .resizable()
                    .scaledToFill()
                    .ignoresSafeArea()
                
                VStack(alignment: .center, spacing: 10) {
                    
                    Button(action: {
                        multipeerSession.host = true
                        multipeerSession.start()
                        showRoomAlert = true
                        HUBPhoneManager.instance.playername = "Host"
                        HUBPhoneManager.instance.allPlayers[0].name = "Host"
                    }) {
                        Image("decorativeRectOrange")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 150, height: 60)
                            .overlay(
                                Text("Host")
                                    .font(.custom("TorukSC-Regular", size: 40))
                                    .foregroundColor(.white)
                            )
                    }
                    
//                    NavigationLink(
//                        destination: GameDifficulty(multipeerSession: multipeerSession),
//                        isActive: $navigateToHost,
//                        label: { EmptyView() }
//                    )
                    
                    
                    Button(action: {
                        
                        multipeerSession.host = false
                        showAlert = true
                       // multipeerSession.configureAsClient()
                    }) {
                        Image("decorativeRectBlue")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 150, height: 60)
                        
                            .overlay(
                                Text("Join")
                                    .font(.custom("TorukSC-Regular", size: 40))
                                    .foregroundColor(.white)
                                
                            )
                    }
                    
                    
                    
                   
                    
                }
                
                
                if showRoomAlert {
                    Color.black.opacity(0.4)
                        .edgesIgnoringSafeArea(.all)
                    
                    VStack(spacing: 20) {
                        Text("Digite o nome da sala")
                            .font(.headline)
                        
                        TextField("Nome", text: $roomName)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .padding(.horizontal)
                        
                        HStack {
                            Button("Cancelar") {
                                showAlert = false
                            }
                            .foregroundColor(.red)
                            
                            Spacer()
                            
                            Button("Salvar") {
                                HUBPhoneManager.instance.roomName = roomName
                             //   multipeerSession.configureAsHost()
                                showAlert = false
                                router = .matchmaking
                                
                            }
                        }
                        .padding(.horizontal)
                    }
                    .padding()
                    .background(Color(.systemBackground))
                    .cornerRadius(16)
                    .shadow(radius: 10)
                    .frame(maxWidth: 300)
                }

                
                if showAlert {
                    Color.black.opacity(0.4)
                        .edgesIgnoringSafeArea(.all)
                    
                    VStack(spacing: 20) {
                        Text("Digite seu nome")
                            .font(.headline)
                        
                        TextField("Seu nome", text: $userName)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .padding(.horizontal)
                        
                        HStack {
                            Button("Cancelar") {
                                showAlert = false
                            }
                            .foregroundColor(.red)
                            
                            Spacer()
                            
                            Button("Salvar") {
                                HUBPhoneManager.instance.playername = userName
                                showAlert = false
                                router = .chooseRoom
                            }
                        }
                        .padding(.horizontal)
                    }
                    .padding()
                    .background(Color(.systemBackground))
                    .cornerRadius(16)
                    .shadow(radius: 10)
                    .frame(maxWidth: 300)
                }
            }
        }
    
}


#Preview {
    HostOrPlayerView(router: .constant(.play))
}
