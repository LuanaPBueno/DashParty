//
//  Untitled.swift
//  DashParty
//
//  Created by Maria Eduarda Mariano on 08/04/25.
//

import SwiftUI
import CoreMotion

struct SessionModeSelectionView: View {
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
            Image("backgroundPhone")
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()
            VStack{
                HStack{
                    Button {
                        router = .start
                    } label: {
                        Image("backButton")
                            .padding(.leading, 35)
                            .padding(.top, 35)

                    }
                    Spacer()
                }
                
                Button(action: {
                    MPCSessionManager.shared.host = true
                    MPCSessionManager.shared.startSession(asHost: true)
                    askForHostName = true
                }) {
                    OrangeButtonPhone(text: "Host", sizeFont: 40)
                        .padding(.vertical, 30)
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
                    BlueButtonPhone(text: "Join", sizeFont: 40)
                        
                    
                }
                .padding(.vertical, 30)
            }
            
            .alert("Insert your name", isPresented: $askForHostName) {
                TextField("Insert your name", text: $userName)
                Button("Cancel", role: .cancel) { }
                
                Button {
                    HUBPhoneManager.instance.allPlayers[0].name = userName
                    HUBPhoneManager.instance.playername = userName

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
                            router = .airplayInstructions

                        } label: {
                            Text("Save")
                        }

                   }
        }
//        .task{
//            multipeerSession.mcAdvertiser.stopAdvertisingPeer()
//        }
    }
 }


#Preview {
    SessionModeSelectionView(router: .constant(.play))
}
