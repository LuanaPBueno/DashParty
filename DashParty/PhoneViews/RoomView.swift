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
            VStack {
                HStack {
                    Button {
                        multipeerSession.mcSession.disconnect()
                        router = .airplayInstructions
                    } label: {
                        Image("backButton")
                            .padding(.leading, 35)
                            .padding(.top, 35)
                        
                    }
                    Spacer()
                }
                
                
                Spacer()
            }
            .ignoresSafeArea()
            
//            if multipeerSession.host {
                VStack{
//                    ZStack{
                        Text(HUBPhoneManager.instance.roomName)
                            .font(.custom("TorukSC-Regular", size: 34, relativeTo: .title2))
                            .multilineTextAlignment(.center)
                            .foregroundStyle(.white)
                            .padding(.top, 35)
                        Spacer()
                        
                        HStack{
                            MMPhone(playerName: HUBPhoneManager.instance.playername , sizePadding: 0)
                            ForEach(multipeerSession.connectedPeersNames, id: \.self) { player in
                                MMPhone(playerName: player, sizePadding: 0)
                            }
                        }
                        .frame(height: UIScreen.main.bounds.height * 0.55)
//                        .background {
//                            Color.red
//                        }
                    Spacer()
                        
//                    }
                }
            VStack{
                Spacer()
                HStack{
                    Spacer()
                    Button {
                        router = .chooseCharacter
                    } label: {
                        OrangeButtonPhone(text: "Continue", sizeFont: 20)
                            .frame(width: 110, height: 45)
                    }
                    .padding(.trailing, 40)
                    .padding(.bottom, 12)
                    
                    
                }
            }
//            }
        }
        .background {
            Image("backgroundPhone")
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()
                .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
        .scrollContentBackground(.hidden)
        
        .task{
            if !multipeerSession.host {
                navigateToPlayerDisplayView = true
            }
            print("vou mandar todos os meus dados")
            
        }
        .onChange(of: multipeerSession.mcSession.connectedPeers.map { $0.displayName }) {
            print(multipeerSession.mcSession.connectedPeers.map { $0.displayName })
        }
        .task{
            print(multipeerSession.host)
            print(multipeerSession.mcSession.myPeerID)
        }
    }
}

