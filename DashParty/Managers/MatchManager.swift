//
//  Match.swift
//  DashParty
//
//  Created by Luana Bueno on 11/03/25.
//

import Foundation
#if canImport(CoreMotion)
import CoreMotion
#endif
import SceneKit


@Observable
class MatchManager {
    var scenes: [SCNRunPathScene] = []
    
    var multipeerSession: MPCSession?
    var receivedMotionData: [UUID: MotionData] = [:]
    var debugText: String = ""
    var balancingResult : [String] = []
    var players: [Player] = []
    var currentPlayerIndex = 0
    
    var tolerancia: Double = 0.03
    var startTime = Date.now
    private var observationToken: Any?
    var currentSituation: Bool = false
    
    var currentChallenge: Challenge = .running
    var youWon: Bool = false
    var interval: TimeInterval = 0.0
    func getPlayer(forUser userID: UUID) -> Player? {
        players.first(where: { $0.user.id == userID })
    }
    var balancingCount: [String: Double] = ["x": 0.0, "y": 0.0, "z": 0.0]
#if canImport(CoreMotion)
    var recentDeviceMotion: [CMDeviceMotion] = []
    #endif
    var tempo: TimeInterval = 10
    
    init() {
        
    }
    
    
    var previousChallenge: [Int:Challenge] = [:]
    func checkAddChallenge(distance: Float, playerIndex: Int) {
        let currentChallenge = GameInformation.instance.allPlayers[playerIndex].currentChallenge
//        guard currentChallenge != previousChallenge[playerIndex] else {
//            return
//        }
        print("Mudou para: \(currentChallenge)")
        switch currentChallenge {
        case .running:
            break
        case .jumping:
            let obstacle = StoneNode(at: distance * 0.2 + 1)
            self.scenes[playerIndex].rootNode.addChildNode(obstacle)
        case .openingDoor:
            print("entrei no case")
            let obstacle = VineNode(at: distance * 0.2 + 1.2)
            self.scenes[playerIndex].rootNode.addChildNode(obstacle)
        case .balancing:
            let obstacle = WaterNode(at: distance * 0.2 + 4)
            let obstacle2 = BridgeNode(at: distance * 0.2 + 4)
            self.scenes[playerIndex].rootNode.addChildNode(obstacle)
            self.scenes[playerIndex].rootNode.addChildNode(obstacle2)
        case .stopped:
            print("nao tem como!")
        }
        previousChallenge[playerIndex] = currentChallenge
    }
    
    //MARK: Setting up multipeer session
    func setupMultipeerSession(_ session: MPCSession) {
           self.multipeerSession = session
           session.peerDataHandler = { [weak self] data, peerID in
               self?.handleReceivedMotionData(data)
           }
       }
    
     func atualizaStart() {
        startTime = Date.now
    }
    
    func reset(){
        print("resetar infos do jogo")
        players[0].startTime = false
        players[0].progress = 0.0
        print("Após mudar o progress pra 0.0, o currentChallenge é: \(GameInformation.instance.allPlayers[0].currentChallenge), \(GameInformation.instance.allPlayers[0].currentSituation)")
        players[0].interval = 0.0
        GameInformation.instance.allPlayers[0].youWon = false
        GameInformation.instance.allPlayers[0].interval = 0.0
        GameInformation.instance.allPlayers[0].progress = 0.0
        
        
      
        GameInformation.instance.matchManager.startMatch(users: [GameInformation.instance.user], myUserID: GameInformation.instance.allPlayers[0].id, index: 0)
        
        print("resetei tudo")
    }
    
    func startMatch(users: [User], myUserID: UUID, index: Int) {
        self.players = users.map { user in
            Player(
                user: users[0],
                
                //MARK: CHANGE
                challenges: [Challenge .jumping, .openingDoor, .balancing ]
                    .flatMap { Array(repeating: $0, count: 4) }
                    .shuffled()
                    .flatMap { [$0, .running] }
                )
            
        }
        //MARK: TIRAR ISSO
        #if DEBUG
        for index in players.indices {
            players[index].challenges[1] = .openingDoor
        }
        #endif
//        self.scenes = users.map { _ in
//            SCNRunPathScene()
//        }
        for userIndex in users.indices {
            let newScene = SCNRunPathScene()
            var color = "red"
            switch GameInformation.instance.allPlayers[userIndex].userClan {
            case .bunny:
                color = "green"
            case .monkey:
                color = "red"
            case .feline:
                color = "yellow"
            case .frog:
                color = "blue"
            default:
                color = "red"
            }
            var images = (1...RunnerNode.totalImages).map{UIImage(named:"\(color)Bunny\($0).png")!}
            let flipped = images.compactMap{ $0.flipped }
            images.append(contentsOf: flipped)
            newScene.runner.animationImages = images
            self.scenes.append(newScene)
        }
//        scenes[currentPlayerIndex].runner.ontrot = checkAddChallenge
        if players[0].startTime == true{
            startTime = Date.now
        }
        self.currentPlayerIndex = index
#if canImport(CoreMotion)
        MotionManager.accelerationInstance.startAccelerometer(
            action: { [weak self] deviceMotion in
                guard let self else { return }
                
                
                let accumulatedElementCount: Int =
                switch players[currentPlayerIndex].currentChallenge {
                case .jumping: 20
                default: 15
                }
                
                if recentDeviceMotion.count >= accumulatedElementCount {
                    recentDeviceMotion = Array(recentDeviceMotion.dropFirst())
                }
                recentDeviceMotion.append(deviceMotion)
                let accumulatedAcceleration = recentDeviceMotion.map { deviceMotion in
                    let x = deviceMotion.userAcceleration.x
                    let y = deviceMotion.userAcceleration.y
                    let z = deviceMotion.userAcceleration.z
                    return (x: x, y: y, z: z)
                }.reduce(into: (x: 0.0, y: 0.0, z: 0.0)) { partialResult, acceleration in
                    partialResult.x += abs(acceleration.x)
                    partialResult.y += abs(acceleration.y)
                    partialResult.z += abs(acceleration.z)
                }
                let averageAcceleration = (
                    x: accumulatedAcceleration.0/Double(recentDeviceMotion.count),
                    y: accumulatedAcceleration.1/Double(recentDeviceMotion.count),
                    z: accumulatedAcceleration.2/Double(recentDeviceMotion.count)
                )
                //  print(averageAcceleration)
                let magnitude = sqrt(pow(averageAcceleration.x, 2) + pow(averageAcceleration.y, 2) + pow(averageAcceleration.z, 2))
                // print(magnitude.formatted(.number.precision(.fractionLength(2))))
                debugText = """
            \(averageAcceleration.x.formatted(.number.precision(.fractionLength(2))))\n
            \(averageAcceleration.y.formatted(.number.precision(.fractionLength(2))))\n
            \(averageAcceleration.z.formatted(.number.precision(.fractionLength(2))))\n
            \(magnitude.formatted(.number.precision(.fractionLength(2))))
            """
                
                switch players[currentPlayerIndex].currentChallenge {
                    
                case .running:
                    currentChallenge = .running
                    
                        GameInformation.instance.allPlayers[0].currentChallenge = .running
                    
                    print(GameInformation.instance.allPlayers[0].currentChallenge)
                    if abs(magnitude) > 0.8
                        && abs(averageAcceleration.y) > abs(averageAcceleration.x)
                        && abs(averageAcceleration.y) > abs(averageAcceleration.z) {
                        
                        currentSituation = true
                      //  DispatchQueue.main.async {
                            GameInformation.instance.allPlayers[0].currentSituation = true
                      //  }
                        players[currentPlayerIndex].progress += magnitude
                        GameInformation.instance.allPlayers[0].progress += magnitude
                        
                        
                        
                    } else {
                        //TODO: muda a animação pra uma parada
                        
                        currentSituation = false
                     //   DispatchQueue.main.async {
                            GameInformation.instance.allPlayers[0].currentSituation = false
                      //  }
                    }
                    
                    
                case .jumping:
                    currentChallenge = .jumping
                  //  DispatchQueue.main.async {
                        GameInformation.instance.allPlayers[0].currentChallenge = .jumping
                  //  }
                    print(GameInformation.instance.allPlayers[0].currentChallenge)

                    if recentDeviceMotion.count >= 3 {
                        let lastThreeY = recentDeviceMotion.suffix(7).map { $0.userAcceleration.y }
                        let currentY = averageAcceleration.y
                        
                        if currentY - lastThreeY.max()! >= 1.5
                            && abs(averageAcceleration.y) > abs(averageAcceleration.x)
                            && abs(averageAcceleration.y) > abs(averageAcceleration.z) {
                            
                            
                            currentSituation = true
                            
                      //      DispatchQueue.main.async {
                                GameInformation.instance.allPlayers[0].currentSituation = true
                       //     }
                            print(currentY, lastThreeY.min()!, lastThreeY.max()!)
                            players[currentPlayerIndex].progress += 100
                            GameInformation.instance.allPlayers[0].progress += 100
                        } else {
                            currentSituation = false
                         //   DispatchQueue.main.async {
                                GameInformation.instance.allPlayers[0].currentSituation = false
                        }
                    }
                    
                case .openingDoor:
                    currentChallenge = .openingDoor
                    GameInformation.instance.allPlayers[0].currentChallenge = .openingDoor
                    print(GameInformation.instance.allPlayers[0].currentChallenge)
                    print("\(GameInformation.instance.allPlayers[0].currentChallenge)")
//                    DispatchQueue.main.async {
//                        HUBPhoneManager.instance.allPlayers[0].currentChallenge = .openingDoor
//                        print("\(HUBPhoneManager.instance.allPlayers[0].currentChallenge)")
//                    }
                    
                    if abs(averageAcceleration.y) < 1
                        && abs(averageAcceleration.y) < abs(averageAcceleration.x)
                        && abs(averageAcceleration.y) < abs(averageAcceleration.z) {
                        currentSituation = true
                        
                  //      DispatchQueue.main.async {
                            GameInformation.instance.allPlayers[0].currentSituation = true
                            
                      //  }
                        players[currentPlayerIndex].progress += 100
                        GameInformation.instance.allPlayers[0].progress += 100
                    } else {
                        currentSituation = false
                      //  DispatchQueue.main.async {
                            GameInformation.instance.allPlayers[0].currentSituation = false
                      //  }
                        
                        
                    }
                    
                case .balancing:
                    currentChallenge = .balancing
                    
                 //   DispatchQueue.main.async {
                        GameInformation.instance.allPlayers[0].currentChallenge = .balancing
                //    }
                    print(GameInformation.instance.allPlayers[0].currentChallenge)

                    balancingCount["x"] = deviceMotion.attitude.roll
                    balancingCount["y"] = deviceMotion.attitude.pitch
                    balancingCount["z"] = deviceMotion.attitude.yaw
                    
                    
                    if balancingCount["x"]! >= -0.01 && balancingCount["y"]! <= 0.2 {
                        balancingResult.append("true")
                        currentSituation = true
                       // DispatchQueue.main.async {
                            GameInformation.instance.allPlayers[0].currentSituation = true
                      //  }
                    }
                    else{
                        currentSituation = false
                      //  DispatchQueue.main.async {
                            GameInformation.instance.allPlayers[0].currentSituation = false
                     //   }
                    }
                    
                    if balancingResult.count == 30 { //para dar 3 segundos, não necessariamente continuos.
                        currentSituation = true
                       // DispatchQueue.main.async {
                            GameInformation.instance.allPlayers[0].currentSituation = true
                     //   }
                        balancingResult = []
                        players[currentPlayerIndex].progress += 100
                        GameInformation.instance.allPlayers[0].progress += 100
                    }
                    
                    
                case .stopped:
                    print("YOU WON")
                    let finishTime = Date()
                    players[currentPlayerIndex].progress += 100
                    GameInformation.instance.allPlayers[0].progress += 100
                    currentChallenge = .stopped
                    youWon = true
                    interval = finishTime.timeIntervalSince(self.startTime)
                    GameInformation.instance.allPlayers[0].interval = finishTime.timeIntervalSince(self.startTime)
                    print("MEU INTERVALO: \(interval)")
                  //  DispatchQueue.main.async {
                        GameInformation.instance.allPlayers[0].youWon = true
                        GameInformation.instance.allPlayers[0].interval = finishTime.timeIntervalSince(self.startTime)
                        GameInformation.instance.allPlayers[0].currentChallenge = .stopped
                  //  }
                    finishMatch()
                    
                case .none:
                    print("None")
                }
                
                
                for playerIndex in players.indices {
                    self.scenes[playerIndex].runner.runAction(
                        SCNAction.move(to: SCNVector3(x: self.scenes[playerIndex].runner.position.x,
                                                      y: self.scenes[playerIndex].runner.position.y,
                                                      z: Float(GameInformation.instance.allPlayers[playerIndex].progress * 0.2)),
                                       duration: 0.1)
                    )
                }
                
            })
        
        #endif
    }
    
    private func handleReceivedMotionData(_ data: Data) {
           do {
               let decoder = JSONDecoder()
               let motionData = try decoder.decode(MotionData.self, from: data)
               
               DispatchQueue.main.async {
                   self.receivedMotionData[motionData.playerId] = motionData
                }
           } catch {
               print("Error decoding motion data: \(error)")
           }
       }
    
    func startRankingUpdates() -> [PlayerState] {
            let ranking = self.getMatchCurrentRanking()
            print("Ranking atualizado:")
            for (index, player) in ranking.enumerated() {
                print("\(index + 1). \(player.name) - progresso: \(player.progress)")
            }
      
        return ranking
    }
    
    func getMatchCurrentRanking() -> [PlayerState] {
        let allProgress = GameInformation.instance.allPlayers.sorted { $0.progress > $1.progress }
        print(allProgress)
        return allProgress
    }
 
    func finishMatch() {
#if canImport(CoreMotion)
        MotionManager.accelerationInstance.stop()
        #endif
    }
}



