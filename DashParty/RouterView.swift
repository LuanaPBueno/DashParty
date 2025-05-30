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
    
    
    
    
    @ViewBuilder
    func backButton(_ run: @escaping () -> Void) -> some View {
        Button {
            run()
        } label: {
            Image("backButton")
        }
        .padding(.leading, 35)
        .padding(.top, 35)
        .ignoresSafeArea()
    }
    var body: some View {
        switch router {
        case .start:
            MoonDashLogoView(router: $router)
                .onAppear {
                    
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
            ShareScreenInstructionView(router: $router, multipeerSession: multipeerSession)
        case .chooseRoom:
            RoomSelectionView(router: $router, multipeerSession: multipeerSession)
        case .waitingRoom:
            MatchmakingGuestView(router: $router, multipeerSession: multipeerSession)
                .overlay(alignment: .topLeading) {
                    backButton({
                        
                        multipeerSession.mcSession.disconnect()
                        router = .chooseRoom
                    })
                }
                .onAppear {
                    GameInformation.instance.broadcastNavigation(to: nil, onTV: .matchmaking)
                }
        case .matchmaking:
            MatchmakingHostView(router: $router, multipeerSession: multipeerSession)
                .task {
                   multipeerSession.startSendingUserDataContinuously()
                }
        case .storyBoard:
            if multipeerSession.isMainPlayer {
                StoryControllerView(router: $router)
                    .onAppear {
                        GameInformation.instance.broadcastNavigation(to: .storyBoard, onTV: .story)
                    }
            }
            else {
                EyesOnTheHub()
            }
        case .tutorial:
            if multipeerSession.isMainPlayer {
                TutorialControllerView(router: $router, multipeerSession: multipeerSession)
                    .onAppear {
                        GameInformation.instance.broadcastNavigation(to: .tutorial, onTV: .tutorial)
                    }
            } else {
                
                EyesOnTheHub()
            }
        case .game:
            EyesOnTheHub()
                .onAppear {
                    GameInformation.instance.broadcastNavigation(to: .game, onTV: .game)
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
