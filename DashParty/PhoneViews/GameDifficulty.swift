//
//  GameDifficulty.swift
//  DashParty
//
//  Created by Maria Eduarda Mariano on 09/04/25.
//

import SwiftUI
import CoreMotion

struct GameDifficulty: View {
    
    var multipeerSession : MPCSession!
    @State var navigate : Bool = false
    @State var changed: Bool = HUBPhoneManager.instance.changeScreen
    @State private var isActive = false
    @State var currentName : String = ""
    @State private var askForHostName = false
    
    
    
    var body: some View {
        
     
            
            ZStack{
                Image("purpleBackground")
                    .resizable()
                    .scaledToFill()
                    .ignoresSafeArea()
                
                HStack(alignment: .center) {
                    
                    Spacer()
                    
                    Button(action: {
                        navigate = true
                    }) {
                        Image("decorativeRectOrange")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 150, height: 60)
                            .overlay(
                                Text("Easy")
                                    .font(.custom("TorukSC-Regular", size: 40))
                                    .foregroundColor(.white)
                            )
                    }
                    
                   
                    Spacer()
                    
                    Button(action: {
                        navigate = true
                    }) {
                        Image("decorativeRectOrange")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 150, height: 120)
                        
                            .overlay(
                                Text("Medium")
                                    .font(.custom("TorukSC-Regular", size: 40))
                                    .foregroundColor(.white)
                                
                            )
                    }
                    
                    NavigationLink(
                        destination: WaitingView(multipeerSession: multipeerSession),
                        isActive: $navigate,
                        label: { EmptyView() }
                    )
                    
                    Spacer()
                    
                    Button(action: {
                        navigate = true
                    }) {
                        Image("decorativeRectOrange")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 150, height: 120)
                        
                            .overlay(
                                Text("Hard")
                                    .font(.custom("TorukSC-Regular", size: 40))
                                    .foregroundColor(.white)
                                
                            )
                    }
                    
                    .alert("Entre com seu nome", isPresented: $askForHostName) {
                        TextField("Entre com seu nome", text: $currentName)
                            Button("Cancelar", role: .cancel) { }
                            
                                Button {
                                    HUBPhoneManager.instance.allPlayers[0].name = currentName
                                    
                                } label: {
                                    Text("Salvar")
                                }

                           }
                    
                    
                    Spacer()
                }
            
        }
    }
}

#Preview {
    GameDifficulty()
}
