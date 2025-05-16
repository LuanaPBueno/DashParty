//
//  HUBPhoneManager.swift
//  DashParty
//
//  Created by Luana Bueno on 24/03/25.
//

import Foundation
import SwiftUI

@Observable
class HUBPhoneManager {
    static let instance = HUBPhoneManager()
    
    var router:Router = .start
    
    var roomName : String = ""
    
    var allRank: [String] = []
    
    var user = User(name: "Eu")
    
    var playername: String = ""
    
    var users: [User] = []
    
    var allPlayers : [SendingPlayer] = []
    
    var receivedPlayers : [SendingPlayer] = []
    
    var narrativeText: [String] = [
       
        "I will tell you a story, the story of FOLOI.",
        
        "Many moons ago, in a magic forest -there was a good and just leader who guided all the clans in harmony.",

        "One day, this leader vanished UNEXPECTEDLY. With FOLOI without protection a new tradition was born…",

        "At each new lunar cycle, every clan selects its best runner to compete for the Staff of the Leader and claim the role of the Guardian FOLOI needs.",

        "Which one will take the lead?"
        ]
    
    var passToTutorialView: Bool = false
    
    var endedGame: Bool = false
    
    var currentName = UIDevice.current.name
    
    var actualPage: Int = 0
    
    var startMatch: Bool = false
    
    var changeScreen: Bool = false
    
    var actualTutorialIndex: Int = 0
    
    var newGame: Bool = false
    
    var matchManager = ChallengeManager()
    
   var ranking = false
   var allPlayersFinished = false

    private init() {
           self.allPlayers = [
               SendingPlayer(
                   id: self.user.id,
                   name: self.playername,
                   currentSituation: self.matchManager.currentSituation,
                   currentChallenge: self.matchManager.currentChallenge,
                   youWon: false,
                   interval: 0.0,
                   progress: 0.0
                   
                   //MARK: ATUALIZAR O MEU BUNNY
               )
           ]
       }
}
