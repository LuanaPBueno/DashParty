//
//  Router.swift
//  DashParty
//
//  Created by Fernanda Auler on 11/04/25.
//

import Foundation

enum Router: Codable {
    //INICIO
    case start
    case options
    case play
    
    //PLAY
    //host: create room e depois choose name
    case createRoom
    //jogador: so para o choosename
    case createName
    //case chooseDifficulty
    
    //so o host
    case airplayInstructions

    //player no chooseroom
    case chooseRoom
    
    //host no matchmaking
    case matchmaking
    
    //case chooseCharacter
    case storyBoard
    
    case chooseCharacter
    
    case tutorial
    
    case game
    
    case victoryStory
    case ranking
    
    case waitingRoom
    
    
    
    
    
    
}
