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
    @State var askForHostName = false
    
    var body: some View {
        ZStack{
            Image("darkblueBackground")
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()
           
            VStack{
                
                HStack{
                    Button {
                        router = .start
                    } label: {
                        Image("backButton")
                            .scaledToFit()
                            .frame(width: 200, height: 150)
                    }
                    Spacer()
                }
                
                
                
                Button(action: {
                    MPCSessionManager.shared.host = true
                    MPCSessionManager.shared.start()
                    //   showRoomAlert = true //MARK: MUDAR ISSO
                    if userName != ""{
                        navigateToHost = true
                    }else{
                        askForHostName = true
                    }
                    MPCSessionManager.shared.startSession(asHost: true)
                    
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
                
                
                Button(action: {
                    MPCSessionManager.shared.host = false
                    MPCSessionManager.shared.startSession(asHost: false)
                    if userName != ""{
                        navigateToHost = true
                    }else{
                        showAlert = true
                    }
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
                
                
                
                Spacer()
            }
            
            .alert("Entre com seu nome", isPresented: $askForHostName) {
                TextField("Entre com seu nome", text: $userName)
                Button("Cancelar", role: .cancel) { }
                
                Button {
                    HUBPhoneManager.instance.allPlayers[0].name = userName
//                    navigateToHost = true
//                    router = .matchmaking
                    showRoomAlert = true
                   
                } label: {
                    Text("Salvar")
                }
                
            }
            
            .alert("Entre com seu nome", isPresented: $showAlert) {
                TextField("Entre com seu nome", text: $userName)
                Button("Cancelar", role: .cancel) { }
                
                Button {
                    HUBPhoneManager.instance.playername = userName
                    showAlert = false
                    
                    multipeerSession.resetSession()
                    router = .chooseRoom
                    
                }
                label: {
                    Text("Salvar")
                }
                
            }
            
            .alert("Entre com o nome da sala", isPresented: $showRoomAlert) {
                TextField("Entre com o nome da sala", text: $roomName)
                    Button("Cancelar", role: .cancel) { }

                        Button {
                            HUBPhoneManager.instance.roomName = roomName
                            showAlert = false
                            navigateToHost = true
                            askForHostName = true
                            multipeerSession.resetSession()
                            router = .matchmaking

                        } label: {
                            Text("Salvar")
                        }

                   }
        }
        .task{
            multipeerSession.mcAdvertiser.stopAdvertisingPeer()
            
        }
    }
 }


#Preview {
    HostOrPlayerView(router: .constant(.play))
}
