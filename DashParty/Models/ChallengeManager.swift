//
//  Match.swift
//  DashParty
//
//  Created by Luana Bueno on 11/03/25.
//

import Foundation
import CoreMotion

@Observable
class ChallengeManager {
    var multipeerSession: MPCSession?
    var receivedMotionData: [UUID: MotionData] = [:] //para cada 
    var debugText: String = ""
    var balancingResult : [String] = []
    var players: [Player] = []
    var currentPlayerIndex = 0
    var tolerancia: Double = 0.03
    var currentSituation: Bool = false
    var currentChallenge: Challenge = .running
    var youWon: Bool = false
    var interval: TimeInterval = 0.0
    func getPlayer(forUser userID: UUID) -> Player? {
        players.first(where: { $0.user.id == userID })
    }
    var balancingCount: [String: Double] = ["x": 0.0, "y": 0.0, "z": 0.0]
    var recentDeviceMotion: [CMDeviceMotion] = []
    
    //MARK: Setting up multipeer session
    func setupMultipeerSession(_ session: MPCSession) {
           self.multipeerSession = session
           session.peerDataHandler = { [weak self] data, peerID in
               self?.handleReceivedMotionData(data)
           }
       }
    
    
    
    func startMatch(users: [User], myUserID: UUID, index: Int) {
        self.players = users.map { user in
            Player(
                user: users[0],
                
                challenges: [Challenge .jumping,/* .openingDoor, .balancing*/]
                    .flatMap { Array(repeating: $0, count: 2) }
                    .shuffled()
                    .flatMap { [$0, .running] }
                )
            
        }
        let startTime = Date.now //MARK: CONFERIR
        self.currentPlayerIndex = index
        AccelerationManager.accelerationInstance.startAccelerometer(
            
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
                DispatchQueue.main.async {
                    HUBPhoneManager.instance.allPlayers[0].currentChallenge = .running
                        }
                if abs(magnitude) > 0.8
                    && abs(averageAcceleration.y) > abs(averageAcceleration.x)
                    && abs(averageAcceleration.y) > abs(averageAcceleration.z) {
                    print("correndo")
                    currentSituation = true
                    DispatchQueue.main.async {
                        HUBPhoneManager.instance.allPlayers[0].currentSituation = true
                            }
                    players[currentPlayerIndex].progress += magnitude
                    
                } else {
                    //TODO: muda a animação pra uma parada
                    print("correndo ignorado")
                    currentSituation = false
                    DispatchQueue.main.async {
                        HUBPhoneManager.instance.allPlayers[0].currentSituation = false
                            }
                   
                    
                    
                }
                
            case .jumping:
                currentChallenge = .jumping
                
                DispatchQueue.main.async {
                    HUBPhoneManager.instance.allPlayers[0].currentChallenge = .jumping
                        }
                if recentDeviceMotion.count >= 3 {
                    let lastThreeY = recentDeviceMotion.suffix(7).map { $0.userAcceleration.y }
                    let currentY = averageAcceleration.y

                    if currentY - lastThreeY.max()! >= 1.5
                        && abs(averageAcceleration.y) > abs(averageAcceleration.x)
                        && abs(averageAcceleration.y) > abs(averageAcceleration.z) {
                        
                        print("pulando detectado")
                        currentSituation = true
                        
                        DispatchQueue.main.async {
                            HUBPhoneManager.instance.allPlayers[0].currentSituation = true
                                }
                        print(currentY, lastThreeY.min()!, lastThreeY.max()!)
                        players[currentPlayerIndex].progress += 100
                    } else {
                        print("pulando ignorado")
                        currentSituation = false
                        DispatchQueue.main.async {
                            HUBPhoneManager.instance.allPlayers[0].currentSituation = false
                                }
                        
                        
                    }
                }

            case .openingDoor:
                currentChallenge = .openingDoor
                DispatchQueue.main.async {
                    HUBPhoneManager.instance.allPlayers[0].currentChallenge = .openingDoor
                        }
               
                if abs(averageAcceleration.y) < 1
                    && abs(averageAcceleration.y) < abs(averageAcceleration.x)
                    && abs(averageAcceleration.y) < abs(averageAcceleration.z) {
                    print("abrindo a porta")
                    currentSituation = true
                    
                    DispatchQueue.main.async {
                        HUBPhoneManager.instance.allPlayers[0].currentSituation = true
                            }
                    players[currentPlayerIndex].progress += 100
                } else {
                    print("porta ignorada")
                    currentSituation = false
                    DispatchQueue.main.async {
                        HUBPhoneManager.instance.allPlayers[0].currentSituation = false
                            }
                   
                    
                }
                
            case .balancing:
                currentChallenge = .balancing
               
                DispatchQueue.main.async {
                    HUBPhoneManager.instance.allPlayers[0].currentChallenge = .balancing
                        }
                balancingCount["x"] = deviceMotion.attitude.roll
                balancingCount["y"] = deviceMotion.attitude.pitch
                balancingCount["z"] = deviceMotion.attitude.yaw
                
                
                if balancingCount["x"]! >= -0.01 && balancingCount["y"]! <= 0.2 {
                    balancingResult.append("true")
                    print("balancing contando")
                    currentSituation = true
                    DispatchQueue.main.async {
                        HUBPhoneManager.instance.allPlayers[0].currentSituation = true
                            }
                }
                else{
                    print("balancing não detectado")
                    currentSituation = false
                    DispatchQueue.main.async {
                        HUBPhoneManager.instance.allPlayers[0].currentSituation = false
                            }
                }
                
                if balancingResult.count == 30 { //para dar 3 segundos, não necessariamente continuos.
                    print("balancing done")
                    currentSituation = true
                    DispatchQueue.main.async {
                        HUBPhoneManager.instance.allPlayers[0].currentSituation = true
                            }
                    balancingResult = []
                    players[currentPlayerIndex].progress += 100
                }
                
            
            case .stopped:
                print("YOU WON")
                let finishTime = Date()
                players[currentPlayerIndex].progress += 100
                currentChallenge = .stopped
                youWon = true
                interval = finishTime.timeIntervalSince(startTime)
                print("MEU INTERVALO: \(interval)")
                DispatchQueue.main.async {
                    HUBPhoneManager.instance.allPlayers[0].youWon = true
                    HUBPhoneManager.instance.allPlayers[0].interval = finishTime.timeIntervalSince(startTime)
                    HUBPhoneManager.instance.allPlayers[0].currentChallenge = .stopped
                        }
                finishMatch()

            case .none:
                print("None")
            }
            
        })
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
    
 
    func finishMatch() {
        AccelerationManager.accelerationInstance.stop()
    }
}



