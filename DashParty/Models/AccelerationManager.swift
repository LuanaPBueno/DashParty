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
    private var motionManager = CMMotionManager() //MARK: Defino aqui o administrador do meu aceletrometro
    
    @Published var motionIntensity: Double = 0.0 //MARK: Intensidade atual do movimento do meu usuário
    @Published var threshold: Double = 1.3 //MARK: Intensidade da gravidade
    @Published var jumpThreshold: Double = 0.7 //MARK: Intensidade da gravidade relacionada a um pulo
     
    @Published var totalMotionIntensity : Double = 0.0 //MARK: Soma de todas as intensidades do usuário a cada 0.1 mili segundo
    
    private var yHistory: [Double] = []
    private let historyLength = 5
    
    func startAccelerometer(form: Binding<AnyView>, status: Binding<String>) {
        if motionManager.isAccelerometerAvailable {
            motionManager.accelerometerUpdateInterval = 0.1
            motionManager.startAccelerometerUpdates(to: .main) { (data, error) in
                if let accelerometerData = data { //MARK: Pega as coordenadas do usuário
                    let x = accelerometerData.acceleration.x
                    let y = accelerometerData.acceleration.y
                    let z = accelerometerData.acceleration.z
                    let magnitude = sqrt(x * x + y * y + z * z)
                    
                    self.yHistory.append(y) //MARK: Bota y em um histórico do pulo
                    if self.yHistory.count > self.historyLength {
                        self.yHistory.removeFirst()
                    }
                    
                    let averageY = self.yHistory.reduce(0, +) / Double(self.yHistory.count) //MARK: ???
                    
                    DispatchQueue.main.async {
                        self.motionIntensity = magnitude //MARK: Verifico se a pessoa ta correndo ou não a partir do motion dela
                        self.totalMotionIntensity += self.motionIntensity
                        if averageY > self.jumpThreshold { //MARK: Se seu y for maior do que o valor que eu estabeleci, então o usuário está pulando
                            status.wrappedValue = "Jumping"
                            print("jumped with Y = \(averageY)")
                            form.wrappedValue = AnyView(
                                Image("greenPerson")
                            )
                        }
                        else if magnitude > self.threshold { //MARK: Se não, o usuário está correndo (caso a magnitude seja maior do que o threshold.
                            status.wrappedValue = "Running"
                            form.wrappedValue = AnyView(Image("bluePerson"))
                        }
                        else { //MARK: Se não, está parado
                            status.wrappedValue = "Stopped"
                            form.wrappedValue = AnyView(Image("orangePerson"))
                        }
                    }
                }
            }
        }
    }
    
    func stopAccelerometer(form: Binding<AnyView>, status: Binding<String>) {
        
        if motionManager.isAccelerometerActive {
           motionManager.stopAccelerometerUpdates()
            //MARK: Fixa o usuário como correndo 
            DispatchQueue.main.async {
                status.wrappedValue = "Running"
                form.wrappedValue = AnyView(Image("bluePerson"))
            }
        }
    }
}
