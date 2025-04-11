//
//  ContentView.swift
//  DashParty
//
//  Created by Luana Bueno on 11/03/25.
//

import SwiftUI
import CoreMotion

struct ContentView: View {
    @Binding var router: Router
    
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
                    Image("logoBranca")
                        .resizable()
                        .scaledToFit()
                        .frame(maxWidth: 500)
                        .padding(.top, 40)
                    
                    Spacer()
                    
                    HStack(alignment: .center){
                        Button(action: {
                            router = .play
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

                        Button(action: {
                            router = .options
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
                    }
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
    ContentView(router: .constant(.start))
}
