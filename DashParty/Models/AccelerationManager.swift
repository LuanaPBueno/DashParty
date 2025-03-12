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
    private var motionManager = CMMotionManager()
    
    @Published var motionIntensity: Double = 0.0
    @Published var threshold: Double = 1.5
    
    func startAccelerometer(form: Binding<AnyView>, status: Binding<String>) {
        if motionManager.isAccelerometerAvailable {
            motionManager.accelerometerUpdateInterval = 0.01
            motionManager.startAccelerometerUpdates(to: .main) { (data, error) in
                if let accelerometerData = data {
                    let x = accelerometerData.acceleration.x
                    let y = accelerometerData.acceleration.y
                    let z = accelerometerData.acceleration.z
                    let magnitude = sqrt(x * x + y * y + z * z)
                    
                    DispatchQueue.main.async {
                        self.motionIntensity = magnitude
                        if magnitude > self.threshold {
                            status.wrappedValue = "Running"
                            form.wrappedValue = AnyView(Circle().frame(width: 100, height: 100))
                        } else {
                            status.wrappedValue = "Stopped"
                            form.wrappedValue = AnyView(Rectangle().frame(width: 100, height: 100))
                        }
                    }
                }
            }
        }
    }
    
    func stopAccelerometer(form: Binding<AnyView>, status: Binding<String>) {
        if motionManager.isAccelerometerActive {
            motionManager.stopAccelerometerUpdates()
            DispatchQueue.main.async {
                status.wrappedValue = "Stopped"
                form.wrappedValue = AnyView(Rectangle().frame(width: 100, height: 100))
            }
        }
    }
}
