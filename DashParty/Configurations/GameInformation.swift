//
//  GameInformation.swift
//  DashParty
//
//  Created by Luana Bueno on 24/03/25.
//

import Foundation
import SwiftUI

@Observable
class GameInformation {
    static let instance = GameInformation()
    
    var router:Router = .start
    
    var routerTV: RouterTV = .logo
    
    var roomName : String = ""
    
    var allRank: [String] = []
    
    var user = User(name: "Eu")
    
    var playername: String = ""
    
    var users: [User] = []
    
    var allPlayers : [PlayerState] = [] //MARK: Todos os dados de todos os jogadores estão aqui!!!
    
    var receivedPlayers : [PlayerState] = []
    
    var narrativeText: [String] = [
       
        "I will tell you a story, the story of FOLOI.",
        
        "Many moons ago, in a magic forest - there was a good and fair leader who guided all clans in harmony.",

        "One day, this leader vanished UNEXPECTEDLY. Without protection a new tradition was born in FOLOI…",

        "Every lunar cycle, each clan selects its best runner to compete for the Staff of the Leader.",
        
        "This champion becomes the Guardian FOLOI needs.",

        "Who will take the lead?"
        ]
    
    var passToTutorialView: Bool = false
    
    var endedGame: Bool = false
    
    var currentName = UIDevice.current.name
    
    var actualPage: Int = 0
    
    var startMatch: Bool = false
    
    var changeScreen: Bool = false
    
    var actualTutorialIndex: Int = 0
    
    var newGame: Bool = false
    
    var matchManager = MatchManager()
    
   var ranking = false
   var allPlayersFinished = false

    private init() {
           self.allPlayers = [
               PlayerState(
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
