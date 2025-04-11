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
                
                VStack(alignment: .center, spacing: 10) {
                    
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
                    
//                    NavigationLink(
//                        destination: GameDifficulty(multipeerSession: multipeerSession),
//                        isActive: $navigateToHost,
//                        label: { EmptyView() }
//                    )
                    
                    
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
                    
                    
                    
                   
                    
                }
                
                .alert("Entre com seu nome", isPresented: $askForHostName) {
                    TextField("Entre com seu nome", text: $userName)
                        Button("Cancelar", role: .cancel) { }
                        
                            Button {
                                HUBPhoneManager.instance.allPlayers[0].name = userName
                                navigateToHost = true
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
                                router = .chooseRoom
                            }

                       }
//                
//                .alert("Entre com o nome da sala", isPresented: $showRoomAlert) {
//                    TextField("Entre com o nome da sala", text: $userName)
//                        Button("Cancelar", role: .cancel) { }
//                        
//                            Button {
//                                HUBPhoneManager.instance.roomName = roomName
//                                showAlert = false
//                                navigateToHost = true
//                                askForHostName = true
//                                
//                            } label: {
//                                Text("Salvar")
//                            }
//
//                       }
                
                
     
                
                
               

                
              
            }
        }
    
}


#Preview {
    HostOrPlayerView(router: .constant(.play))
}
