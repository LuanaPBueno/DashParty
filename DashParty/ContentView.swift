//
//  ContentView.swift
//  DashParty
//
//  Created by Luana Bueno on 11/03/25.
//

import SwiftUI
import CoreMotion

struct ContentView: View {
    @State private var status: String = "Stopped"
    @State private var form: AnyView = AnyView(Rectangle().frame(width: 100, height: 100))
    @State private var motionIntensity: Double = 0.0
    @State private var challenges: [String] = ["Jump", "Mimic", "Spin", "Crawl"]
    @State private var currentChallenge: String = ""

    @State private var motionManager = CMMotionManager()
    @State private var threshold: Double = 1.5
    @State private var jumpThreshold: Double = 1.2 // Limite para detectar variação em Y no salto
    @State private var lastYAcceleration: Double = 0.0 // Para armazenar o valor anterior de aceleração no eixo Y

    var body: some View {
        VStack {
            form
                .foregroundColor(.blue)
                .padding()

            Text("Movement Intensity: \(motionIntensity, specifier: "%.2f")")
                .font(.subheadline)
            
            Text("\(status)")

            Text("Challenge: \(currentChallenge.isEmpty ? "No challenge..." : currentChallenge)")
                .font(.title)
                .padding()
        }
        .onAppear {
            checkAndStartAccelerometer()

            if currentChallenge == "" {
                startChallengeLoop()
            }
        }
        .onDisappear {
            stopAccelerometer()
        }
    }

    func startAccelerometer() {
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
                            self.status = "Running"
                            self.form = AnyView(Circle().frame(width: 100, height: 100))
                        } else {
                            self.status = "Stopped"
                            self.form = AnyView(Rectangle().frame(width: 100, height: 100))
                        }

                        // Se o desafio for "Jump", detecta a variação em Y
                        if self.currentChallenge == "Jump" {
                            self.detectJump(yAcceleration: y)
                        }
                    }
                }
            }
        }
    }

    func stopAccelerometer() {
        if motionManager.isAccelerometerActive {
            motionManager.stopAccelerometerUpdates()
        }
    }

    func checkAndStartAccelerometer() {
        if currentChallenge.isEmpty {
            startAccelerometer()
        } else {
            stopAccelerometer()
        }
    }

    func startChallengeLoop() {
        Timer.scheduledTimer(withTimeInterval: 10, repeats: true) { _ in
            DispatchQueue.main.async {
                self.currentChallenge = ""

                DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
                    if let newChallenge = self.challenges.randomElement() {
                        self.currentChallenge = newChallenge
                        self.checkChallenge(challenge: newChallenge)
                    }
                    stopAccelerometer()
                }

                DispatchQueue.main.asyncAfter(deadline: .now() + 10) {
                    self.currentChallenge = ""
                    startAccelerometer()
                }
            }
        }
    }

    func checkChallenge(challenge: String) {
        print("New challenge: \(challenge)")
        
        if challenge == "Jump" {
        
        }
    }
    
    func detectJump(yAcceleration: Double) {
        // Verifica se houve uma variação significativa em Y
        if abs(yAcceleration - lastYAcceleration) > jumpThreshold {
            self.status = "Jumping!"
            print("Jump detected with Y acceleration change: \(yAcceleration)")
        } else {
            self.status = "Not jumping"
        }

        // Atualiza a última aceleração Y
        self.lastYAcceleration = yAcceleration
    }
}

#Preview{
    ContentView()
}
