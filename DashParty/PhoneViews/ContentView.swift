//
//  ContentView.swift
//  DashParty
//
//  Created by Luana Bueno on 11/03/25.
//

import SwiftUI
import CoreMotion

struct ContentView: View {
    @State var changed: Bool = HUBPhoneManager.instance.changeScreen
    @State private var isActive = false
    let user = User(name: "Eu")
    @State var matchManager = ChallengeManager()
    var users: [User] = [User(name: "A"), User(name: "B")]

    var myPlayer: Player? {
        matchManager.getPlayer(forUser: user.id)
    }

    var body: some View {
        NavigationStack{
            GeometryReader { geometry in
                ZStack {
                    Image("chooseLevelBackground")
                        .resizable()
                        .scaledToFill()
                        .edgesIgnoringSafeArea(.all)
                        .frame(width: geometry.size.width, height: geometry.size.height)

                    Image("goldenLogo")
                        .resizable()
                        .scaledToFit()
                        .frame(width: geometry.size.width * 0.4)
                        .offset(x: geometry.size.width * 0.20, y: -geometry.size.height * 0.38)

                    Image("dashLogo")
                        .resizable()
                        .scaledToFit()
                        .frame(width: geometry.size.width * 0.3)
                        .offset(x: geometry.size.width * 0.20, y: -geometry.size.height * 0.20)

//                    if let myPlayer {
//                        VStack {
//                            Text("Challenge: \(myPlayer.currentChallenge?.name ?? "Nenhum")")
//                                .font(.title)
//                                .padding()
//                        }
//                    } else {
                        VStack(alignment: .trailing, spacing: 18) {
                                Button(action: {
                                    HUBPhoneManager.instance.changeScreen = true
                                    isActive = true
                                }) {
                                    Image("easyMode")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 200)
                                }

                            Button(action: {
                                HUBPhoneManager.instance.changeScreen = true
                                isActive = true
                            }) {
                                Image("normalMode")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 200)
                            }
                            
                            Button(action: {
                                HUBPhoneManager.instance.changeScreen = true
                                isActive = true
                            }) {
                                Image("hardMode")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 200)
                            }
                            
                            NavigationLink(
                                destination: /*CharacterView(users: users, user: user, matchManager: matchManager)*/ConnectInHubView(),
                                isActive: $isActive,
                                label: { EmptyView() } 
                            )

                            NavigationLink(destination: CreditsView()) {
                                Image("credits")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 200)
                            }
                        }
                        .frame(maxWidth: .infinity, alignment: .trailing)
                        .padding(.trailing, 40)
                        .padding(.top, 120)
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
