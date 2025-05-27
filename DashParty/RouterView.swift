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
            MoonDashLogoView(router: $router)
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
            SessionModeSelectionView(router: $router)
        case .createRoom:
            Text("CreateRoom")
        case .createName:
            Text("CreateName")
        case .airplayInstructions:
            ShareScreenInstructionView(router: $router)
        case .chooseRoom:
            RoomSelectionView(router: $router, multipeerSession: multipeerSession)
        case .waitingRoom:
            MatchmakingGuestView(router: $router, multipeerSession: multipeerSession)
        case .matchmaking:
            MatchmakingHostView(router: $router, multipeerSession: multipeerSession)
                .task {
                   
                        multipeerSession.startSendingUserDataContinuously()

                    
                }
        case .storyBoard:
            if multipeerSession.host {
                StoryControllerView(router: $router)
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
            TutorialControllerView(router: $router, multipeerSession: multipeerSession)
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
            RankingView(router: $router, kikoType: .red)
                .onAppear {
                           do {
                               let data = try JSONEncoder().encode(EventMessage.navigation(.ranking))
                               multipeerSession.sendDataToAllPeers(data: data)
                           }
                           catch {
                               print(error)
                           }
                       }
        case .chooseCharacter:
            CharacterSelectionView(router: $router)
                .onAppear {
                        do {
                            let data = try JSONEncoder().encode(EventMessage.navigation(.chooseCharacter))
                            multipeerSession.sendDataToAllPeers(data: data)
                        }
                        catch {
                            print(error)
                        }
                    }
            }
    }
}

#Preview {
    RouterView(router: .constant(.start))
}
