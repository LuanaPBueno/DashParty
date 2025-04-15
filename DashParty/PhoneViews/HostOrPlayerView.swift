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
                Button {
                    router = .start
                } label: {
                    Image("backButton")
                }
Spacer()
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
            
            .alert("Insert your name", isPresented: $askForHostName) {
                TextField("Insert your name", text: $userName)
                Button("Cancel", role: .cancel) { }
                
                Button {
                    HUBPhoneManager.instance.allPlayers[0].name = userName
//                    navigateToHost = true
//                    router = .matchmaking
                    showRoomAlert = true
                   
                } label: {
                    Text("Save")
                }
                
            }
            
            .alert("Insert your name", isPresented: $showAlert) {
                TextField("Insert your name", text: $userName)
                Button("Cancel", role: .cancel) { }
                
                Button {
                    HUBPhoneManager.instance.playername = userName
                    showAlert = false
                    
                    multipeerSession.resetSession()
                    router = .chooseRoom
                    
                }
                label: {
                    Text("Save")
                }
                
            }
            
            .alert("Insert the room's name", isPresented: $showRoomAlert) {
                TextField("Insert the room's name", text: $roomName)
                    Button("Cancel", role: .cancel) { }

                        Button {
                            HUBPhoneManager.instance.roomName = roomName
                            showAlert = false
                            navigateToHost = true
                            askForHostName = true
                            multipeerSession.resetSession()
                            router = .matchmaking

                        } label: {
                            Text("Save")
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
