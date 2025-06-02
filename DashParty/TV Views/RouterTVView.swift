//
//  RouterTVView.swift
//  DashParty
//
//  Created by Victor Martins on 28/05/25.
//

import SwiftUI

let roomNames = [
    "Lunar Grove",
"Moontrail",
"Starleaf Den",
"Dashlight Hollow",
"Forest Flicker",
"Moonbounce Meadow",
"Howl Haven",
"Whimsy Woods",
"Twilight Run",
"Mystic Thicket",
"Glimmer Glade",
"Shadow Sprint",
"Moondust Arena",
"Wanderwild",
"Stardash Circle",
"Glowburrow",
"Lunabound",
"Wispfield",
"Echo Hollow",
"Nimbus Nest",
"Lunar Arena",
"Kiko’s Trial",
"Moonclash Grounds",
"Celestial Circuit",
"Mystic Dash",
"Shadow Sprintgrounds",
"Hollow Racepath",
"Clashwood Vale",
"Starlit Arena",
"The Glade of Trials",
"Thumper's Challenge",
"Moonfang Track",
"Twilight Tussle",
"Runebound Run",
"Dash of the Clans",
"Whisker Wars",
"Burrow Blitz",
"Kiko’s Gauntlet",
"The Moonrun",
"Nocturne Dash",
"Kiko’s Moontrial",
"The Dashring",
"Mystic Chase",
"Hareground",
"Mooncall Arena",
"Forest Fray",
"Starveil Circuit",
"Burrow Battle",
"The Glimmer Gauntlet",
"Clash of the Clans",
"Kiko’s Sprintspire",
"The Hollow Run",
"Enchanted Track",
"Nightroot Arena",
"Lunavale Clash",
"Whisker Challenge",
"The Moon Trials",
"Dashbound Den",
"Warren Wars",
"Arcane Arena",
"Carrot Clash",
"The Carrot Cup",
"Warren Dash",
"The Lunar Hop",
"Hare Hustle",
"Kiko’s Carrot Chase",
"The Jumping Glade",
"Mystic Burrow",
"Carrot Quest",
"Thumper Trials",
"Golden Carrot Run",
"The Velvet Sprint",
"Hopfinity Track",
"Whisker Run",
"Kiko’s Hop-Off",
"Moonroot Warren",
"Bunny Battleground",
"Carrot Craze Arena",
"The Enchanted Hutch.",
]

struct RouterTVView: View {
    
    @Binding var router: RouterTV
    
    let user = GameInformation.instance.user
    @State var multipeerSession = MPCSessionManager.shared
    @State var matchManager = GameInformation.instance.matchManager
    var body: some View {
        ZStack {
            switch router {
            case .logo:
                MoonDashLogoTVView(router: $router)
            case .matchmaking, .characterSelection:
                GeometryReader { geo in
                    MatchmakingTVView(router: $router, multipeerSession: multipeerSession, size: geo.size)
                        .onAppear {
                            GameInformation.instance.allPlayers[0].name = "TV"
                            GameInformation.instance.playername = "TV"
                            MPCSessionManager.shared.host = true
                            MPCSessionManager.shared.startSession(asHost: true)
                            GameInformation.instance.roomName = roomNames.randomElement()!
                            MPCSessionManager.shared.resetSession()
                        }
                }
//            case .characterSelection:
//                CharacterSelectionTVView(router: $router)
            
            case .story:
                GeometryReader { geo in
                    StoryHubView(size: geo.size)
                }
                .onAppear {
                    GameInformation.instance.users = GameInformation.instance.allPlayers.map { player in
                            return User(
                                id: player.id,
                                name: ""
                            )
                        }
                }
            case .tutorial:
                TutorialHubTVView(router: $router)
            case .game:
                MatchHubTVView(router: $router, count: multipeerSession.mcSession.connectedPeers.count, user: user, matchManager: matchManager)
            case .ranking:
                Text("")
            }
        }
        .animation(.default, value: router)
    }
}

