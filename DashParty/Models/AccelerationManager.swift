//
//  ChallengesTrack.swift
//  DashParty
//
//  Created by Luana Bueno on 11/03/25.
//

import Foundation
import SwiftUI
import CoreMotion

class AccelerationManager: ObservableObject {
    static let accelerationInstance = AccelerationManager()
    private init() { }
    private var motionManager = CMMotionManager() //MARK: Defino aqui o administrador do meu aceletrometro
    
    @Published var motionIntensity: Double = 0.0 //MARK: Intensidade atual do movimento do meu usuário
    @Published var threshold: Double = 1.3 //MARK: Intensidade da gravidade
    @Published var jumpThreshold: Double = 0.7 //MARK: Intensidade da gravidade relacionada a um pulo
     
    @Published var totalMotionIntensity : Double = 0.0 //MARK: Soma de todas as intensidades do usuário a cada 0.1 mili segundo
    
    private var yHistory: [Double] = []
    private let historyLength = 5
    
    
    func startAccelerometer(action: @escaping (CMDeviceMotion) -> Void) {
        
        guard motionManager.isDeviceMotionAvailable else {
            return
        }
        motionManager.deviceMotionUpdateInterval = 0.05
        motionManager.startDeviceMotionUpdates(to: .main) { deviceMotion, error in
            if let error {
                print(error.localizedDescription)
            }
            guard let deviceMotion else {
                print("Sem devicemotion")
                return
            }
            action(deviceMotion)
        }
    }
    
    func stop() {
        self.motionManager.stopDeviceMotionUpdates()
    }

}
