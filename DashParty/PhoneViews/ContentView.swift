//
//  ContentView.swift
//  DashParty
//
//  Created by Luana Bueno on 11/03/25.
//

import SwiftUI
import CoreMotion

struct ContentView: View {
    
    var multipeerSession : MPCSession!
    @State var navigate : Bool = false
    @State var changed: Bool = HUBPhoneManager.instance.changeScreen
    @State private var isActive = false
    
    //    let user = User(name: "Eu")
    //    var users: [User] = [User(name: "A"), User(name: "B")]
    //
    //    var myPlayer: Player? {
    //        matchManager.getPlayer(forUser: user.id)
    //    }
    
    var body: some View {
        NavigationStack{
           
            ZStack{
                
                Image("firstBackground")
                    .resizable()
                    .scaledToFill()
                    .ignoresSafeArea()

                
                VStack{
                    
                    Spacer()
                    //                    if let myPlayer {
                    //                        VStack {
                    //                            Text("Challenge: \(myPlayer.currentChallenge?.name ?? "Nenhum")")
                    //                                .font(.title)
                    //                                .padding()
                    //                        }
                    //                    } else {
                    
                    
                    
                    Image("logoBranca")
                        .resizable()
                        .scaledToFit()
                        .frame(maxWidth: 500)
                        .padding(.top, 40)
                    
                    Spacer()
                    
                    HStack(alignment: .center){
                        Button(action: {
                            navigate = true
                        }) {
                            Image("decorativeRectOrange")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 150, height: 60)
                                .overlay(
                                    Text("PLAY")
                                        .font(.custom("TorukSC-Regular", size: 28))
                                        .foregroundColor(.white)
                                )
                        }
                        
                        NavigationLink(
                            destination: HostOrPlayerView(),
                          //  destination: ChooseHierarchyView(),
                            isActive: $navigate,
                            label: { EmptyView() }
                        )
                        
                        
                        Button(action: {
                            navigate = true
                        }) {
                            Image("decorativeRectOrange")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 150, height: 60)
                                .overlay(
                                    Text("Options")
                                        .font(.custom("TorukSC-Regular", size: 28))
                                        .foregroundColor(.white)
                                    
                                )
                        }
                        
                        NavigationLink(
                            destination: CreditsView(),
                            isActive: $navigate,
                            label: { EmptyView() }
                        )
                    }
                    
                    
                    //                            NavigationLink(
                    //                                destination: /*CharacterView(users: users, user: user, matchManager: matchManager)*/ConnectInHubView(),
                    //                                isActive: $isActive,
                    //                                label: { EmptyView() }
                    //                            )
                    
                   Spacer()
                }
            }
           
                .navigationDestination(isPresented: $isActive) {
                                      //  ChooseHierarchyView/()
                }
            }
        }
    }


#Preview {
    ContentView()
}
