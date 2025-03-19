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
    
    var debugText: String = ""
    var balancingResult : [String] = []
    var players: [Player] = []
    var currentPlayerIndex = 0
    var tolerancia: Double = 0.03
    func getPlayer(forUser userID: UUID) -> Player? {
        players.first(where: { $0.user.id == userID })
    }
    var balancingCount: [String: Double] = ["x": 0.0, "y": 0.0, "z": 0.0]
    var recentDeviceMotion: [CMDeviceMotion] = []
    
    func startMatch(users: [User], myUserID: UUID) {
        self.players = users.map { user in
            Player(
                user: user,
                challenges: [Challenge .running, .jumping, .running, .openingDoor, .running, .balancing, .running]
            )
        }
        self.currentPlayerIndex = self.players.firstIndex(where: { $0.user.id == myUserID })!
        AccelerationManager.accelerationInstance.startAccelerometer(
            action: { [weak self] deviceMotion in
                guard let self else { return }
                
                let accumulatedElementCount: Int =
                    switch players[currentPlayerIndex].currentChallenge {
                    case .jumping: 20
                    default: 15
                    }
                                
                //MARK: Ao invés de ser 4, vai ter que mudar pra jump
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
                if abs(magnitude) > 0.8
                    && abs(averageAcceleration.y) > abs(averageAcceleration.x)
                    && abs(averageAcceleration.y) > abs(averageAcceleration.z) {
                    print("correndo")
//                    print(players[currentPlayerIndex].progress)
                    players[currentPlayerIndex].progress += magnitude
                } else {
                    print("correndo ignorado") //TODO: muda a animação pra uma parada
                }
                
            case .jumping:
                if recentDeviceMotion.count >= 3 {
                    let lastThreeY = recentDeviceMotion.suffix(7).map { $0.userAcceleration.y }
                    let currentY = averageAcceleration.y

                    if currentY - lastThreeY.max()! >= 1.5
                        && abs(averageAcceleration.y) > abs(averageAcceleration.x)
                        && abs(averageAcceleration.y) > abs(averageAcceleration.z) {
                        
                        print("pulando detectado")
                        print(currentY, lastThreeY.min()!, lastThreeY.max()!)
                        players[currentPlayerIndex].progress += 100
                    } else {
                        print("pulando ignorado")
                    }
                }

            case .openingDoor:
                if abs(averageAcceleration.y) < 1
                    && abs(averageAcceleration.y) < abs(averageAcceleration.x)
                    && abs(averageAcceleration.y) < abs(averageAcceleration.z) {
                    print("abrindo a porta")
                    players[currentPlayerIndex].progress += 100
                } else {
                    print("porta ignorada")
                }
                
            case .balancing:
                balancingCount["x"] = deviceMotion.attitude.roll
                balancingCount["y"] = deviceMotion.attitude.pitch
                balancingCount["z"] = deviceMotion.attitude.yaw
                print("rotation x:\( balancingCount["x"]!), rotation y: \( balancingCount["y"]!), rotation z: \( balancingCount["z"]!)")
                
                if balancingCount["x"]! >= -0.01 && balancingCount["y"]! <= 0.2 {
                    balancingResult.append("true")
                   
                }
               
                if balancingResult.count == 30{ //para dar 3 segundos, não necessariamente continuos.
                    players[currentPlayerIndex].progress += 100
                }

            }
            
        })
    }
    
    
    func finishMatch() {
        AccelerationManager.accelerationInstance.stop()
    }
}



