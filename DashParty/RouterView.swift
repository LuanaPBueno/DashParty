//
//  RouterView.swift
//  DashParty
//
//  Created by Fernanda Auler on 11/04/25.
//

import SwiftUI

struct RouterView: View {
    @Binding var router:Router
    var multipeerSession : MPCSession = MPCSessionManager.shared
    var body: some View {
        switch router {
        case .start:
            ContentView(router: $router)
                .onAppear {
                    do {
                        let data = try JSONEncoder().encode(EventMessage.navigation(.start))
                        multipeerSession.sendDataToAllPeers(data: data)
                    }
                    catch {
                        print(error)
                    }
                }
            
        case .options:
            OptionsView()
        case .play:
            HostOrPlayerView(router: $router)
        case .createRoom:
            Text("CreateRoom")
        case .createName:
            Text("CreateName")
        case .airplayInstructions:
            ReadyView(router: $router)
        case .chooseRoom:
            RoomListView(router: $router, multipeerSession: multipeerSession)
        case .waitingRoom:
            WaitingView(router: $router, multipeerSession: multipeerSession)
        case .matchmaking:
            RoomView(router: $router, multipeerSession: multipeerSession)
        case .storyBoard:
            if multipeerSession.host {
                NarrativePassingView(router: $router)
                    .onAppear {
                        do {
                            let data = try JSONEncoder().encode(EventMessage.navigation(.storyBoard))
                            multipeerSession.sendDataToAllPeers(data: data)
                        }
                        catch {
                            print(error)
                        }
                    }
            }
            else {
                EyesOnTheHub()
            }
        case .tutorial:
            TutorialPassingView(router: $router, multipeerSession: multipeerSession)
                .onAppear {
                    do {
                        let data = try JSONEncoder().encode(EventMessage.navigation(.tutorial))
                        multipeerSession.sendDataToAllPeers(data: data)
                    }
                    catch {
                        print(error)
                    }
                }
            
            
            
        case .game:
            EyesOnTheHub()
                .onAppear {
                    do {
                        let data = try JSONEncoder().encode(EventMessage.navigation(.game))
                        multipeerSession.sendDataToAllPeers(data: data)
                    }
                    catch {
                        print(error)
                    }
                }
        case .victoryStory:
            Text("Victory")
        case .ranking:
            YouWonView(router: $router)
        case .chooseCharacter:
            CharacterView(router: $router)
        }
    }
}

#Preview {
    RouterView(router: .constant(.start))
}
