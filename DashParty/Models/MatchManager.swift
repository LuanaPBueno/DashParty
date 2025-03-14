//
//  Match.swift
//  DashParty
//
//  Created by Luana Bueno on 11/03/25.
//

import Foundation
import CoreMotion

@Observable
class MatchManager {
    
    var debugText: String = ""
    
    var players: [Player] = []
    var currentPlayerIndex = 0
    func getPlayer(forUser userID: UUID) -> Player? {
        players.first(where: { $0.user.id == userID })
    }
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
                    case .jumping: 8
                    default: 4
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
                    partialResult.x += acceleration.x
                    partialResult.y += acceleration.y
                    partialResult.z += acceleration.z
                }
                let averageAcceleration = (
                    x: accumulatedAcceleration.0/Double(recentDeviceMotion.count),
                    y: accumulatedAcceleration.1/Double(recentDeviceMotion.count),
                    z: accumulatedAcceleration.2/Double(recentDeviceMotion.count)
                )
                print(averageAcceleration)
            let magnitude = sqrt(pow(averageAcceleration.x, 2) + pow(averageAcceleration.y, 2) + pow(averageAcceleration.z, 2))
                print(magnitude.formatted(.number.precision(.fractionLength(2))))
            debugText = """
            \(averageAcceleration.x.formatted(.number.precision(.fractionLength(2))))\n
            \(averageAcceleration.y.formatted(.number.precision(.fractionLength(2))))\n
            \(averageAcceleration.z.formatted(.number.precision(.fractionLength(2))))\n
            \(magnitude.formatted(.number.precision(.fractionLength(2))))
            """
            
            switch players[currentPlayerIndex].currentChallenge {
            case .running:
                if abs(averageAcceleration.y) > 1
                    && abs(averageAcceleration.y) > abs(averageAcceleration.x)
                    && abs(averageAcceleration.y) > abs(averageAcceleration.z) {
                    print("correndo")
                    print(players[currentPlayerIndex].progress)
                    players[currentPlayerIndex].progress += magnitude
                } else {
                    print("correndo ignorado") //TODO: muda a animação pra uma parada
                }
                
            case .jumping:
                if abs(averageAcceleration.y) > 1.5
                    && abs(averageAcceleration.y) > abs(averageAcceleration.x)
                    && abs(averageAcceleration.y) > abs(averageAcceleration.z) {
                    print("pulando")
                    players[currentPlayerIndex].progress += 100
                } else {
                    print("pulando ignorado")
                }
            case .openingDoor:
                if abs(averageAcceleration.y) < 1
                    && abs(averageAcceleration.y) < abs(averageAcceleration.x)
                    && abs(averageAcceleration.y) < abs(averageAcceleration.z) {
                    print("abrindo a porta")
                    players[currentPlayerIndex].progress += magnitude
                } else {
                    print("porta ignorada")
                }
            case .balancing:
                print("Not implemented balancing")
            
            }
            
        })
    }
    
    
    func finishMatch() {
        AccelerationManager.accelerationInstance.stop()
    }
}



