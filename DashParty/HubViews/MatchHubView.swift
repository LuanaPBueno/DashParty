//
//  MathLazyGrade.swift
//  DashParty
//
//  Created by Luana Bueno on 02/04/25.
//
import SwiftUI
import Foundation

struct MatchHubView: View {
    @Binding var router:Router
    let count: Int
    let players = GameInformation.instance.allPlayers
    let users: [User] = GameInformation.instance.users
    let user: User
    var matchManager: MatchManager
    @State private var timer: Timer?
     var ranking = GameInformation.instance.ranking
     var allPlayersFinished = GameInformation.instance.allPlayersFinished
    @State var audioManager: AudioManager = AudioManager()

    var body: some View {
        
        let totalPlayers =  GameInformation.instance.allPlayers.count
        ZStack{
            VStack(spacing: 0){
                
                HStack(spacing: 0) {
                    
                    PlayerSceneView(users: users, index: 0, matchManager: matchManager) //SOU EU
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .clipped()
                    
                    if totalPlayers >= 2 {
                        PlayerSceneView(users: users, index: 1, matchManager: matchManager) //jogador 1
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                            .clipped()
                            .task{
                                print()
                            }
                        
                    }
                    
                    if totalPlayers == 3 {
                        PlayerSceneView(users: users, index: 2, matchManager: matchManager) //jogador 2
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                            .clipped()
                        
                        
                    }
                }
                
                HStack(spacing: 0){
                    
                    if totalPlayers > 3 {
                        PlayerSceneView(users: users, index: 2, matchManager: matchManager) //jogador 2
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                            .clipped()
                    }
                    
                    if totalPlayers == 4 {
                        PlayerSceneView(users: users, index: 3, matchManager: matchManager)
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                            .clipped()
                    }
                }
            }
            HStack{
                ProgressBarView()
                    .padding()
                Spacer()
            }
        }
            .task{
                audioManager.playSound(named: "Run Music")
                print("number of players: \(players.count)")
                for (index, player) in Array(GameInformation.instance.allPlayers.enumerated()) {
                    matchManager.startMatch(users: users, myUserID: GameInformation.instance.allPlayers[index].id, index: index)
                }
                
                print("Created matches")
                startCheckingForAllWinners()
            }
            .onDisappear {
                timer?.invalidate()
            }
            .frame(maxHeight: .infinity)
            .ignoresSafeArea()
            
            
        
    }
    
    //MARK: Agora, quando tiver só com um jogador final correndo, o jogo já passa pra tela de ranking
    private func startCheckingForAllWinners() {
        timer?.invalidate()
        
        timer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: true) { _ in
            let players = GameInformation.instance.allPlayers
            let winnersCount = players.filter { $0.youWon == true }.count
            
            if players.count == 1 {
                if winnersCount == 1 {
                    GameInformation.instance.allPlayersFinished = true
                    GameInformation.instance.ranking = true
                    let rankedPlayers = GameInformation.instance.getRankedPlayers()
                    do {
                        let encodedData = try JSONEncoder().encode(rankedPlayers[0].player.name)
                        MPCSessionManager.shared.sendDataToAllPeers(data: encodedData)
                    } catch {
                        print("Erro ao codificar os dados do usuário: \(error)")
                    }

                    
                    router = .ranking
                    timer?.invalidate()
                }
             
            } else {
                if winnersCount == players.count - 1 {
                    GameInformation.instance.allPlayersFinished = true
                    GameInformation.instance.ranking = true
                    let rankedPlayers = GameInformation.instance.getRankedPlayers()
                    do {
                        let encodedData = try JSONEncoder().encode([rankedPlayers[0].player.name])
                        MPCSessionManager.shared.sendDataToAllPeers(data: encodedData)
                    } catch {
                        print("Erro ao codificar os dados do usuário: \(error)")
                    }
                    router = .ranking
                    timer?.invalidate()
                }
            }
        }
    }
    
 
}

struct MatchHubTVView: View {
    @Binding var router:RouterTV
    let count: Int
    let players = GameInformation.instance.allPlayers
    let users: [User] = GameInformation.instance.users
    let user: User
    var matchManager: MatchManager
    @State private var timer: Timer?
    var ranking = GameInformation.instance.ranking
    var allPlayersFinished = GameInformation.instance.allPlayersFinished
    @State var audioManager: AudioManager = AudioManager()
    
    var body: some View {
        
        let totalPlayers =  GameInformation.instance.allPlayers.count
        ZStack{
            VStack(spacing: 0){
                
                HStack(spacing: 0) {
                    
                    PlayerSceneView(users: users, index: 0, matchManager: matchManager) //SOU EU
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .clipped()
                    
                    if totalPlayers >= 2 {
                        PlayerSceneView(users: users, index: 1, matchManager: matchManager) //jogador 1
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                            .clipped()
                            .task{
                                print()
                            }
                        
                    }
                    
                    if totalPlayers == 3 {
                        PlayerSceneView(users: users, index: 2, matchManager: matchManager) //jogador 2
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                            .clipped()
                        
                        
                    }
                }
                
                HStack(spacing: 0){
                    
                    if totalPlayers > 3 {
                        PlayerSceneView(users: users, index: 2, matchManager: matchManager) //jogador 2
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                            .clipped()
                    }
                    
                    if totalPlayers == 4 {
                        PlayerSceneView(users: users, index: 3, matchManager: matchManager)
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                            .clipped()
                    }
                }
            }
            HStack{
                ProgressBarView()
                    .padding()
                Spacer()
            }
        }
        .task{
            audioManager.playSound(named: "Run Music")
            print("number of players: \(players.count)")
            for (index, player) in Array(GameInformation.instance.allPlayers.enumerated()) {
                matchManager.startMatch(users: users, myUserID: GameInformation.instance.allPlayers[index].id, index: index)
            }
            
            print("Created matches")
            startCheckingForAllWinners()
        }
        .onDisappear {
            timer?.invalidate()
        }
        .frame(maxHeight: .infinity)
        .ignoresSafeArea()
        
        
        
    }
    
    //MARK: Agora, quando tiver só com um jogador final correndo, o jogo já passa pra tela de ranking
    private func startCheckingForAllWinners() {
        timer?.invalidate()
        
        timer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: true) { _ in
            let players = GameInformation.instance.allPlayers
            let winnersCount = players.filter { $0.youWon == true }.count
            
            if players.count == 1 {
                if winnersCount == 1 {
                    GameInformation.instance.allPlayersFinished = true
                    GameInformation.instance.ranking = true
                    router = .ranking
                    timer?.invalidate()
                }
                
            } else {
                if winnersCount == players.count - 1 {
                    GameInformation.instance.allPlayersFinished = true
                    GameInformation.instance.ranking = true
                    router = .ranking
                    timer?.invalidate()
                }
            }
        }
    }
}
