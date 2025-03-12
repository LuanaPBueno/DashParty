//
//  ContentView.swift
//  DashParty
//
//  Created by Luana Bueno on 11/03/25.
//

import SwiftUI
import CoreMotion

struct ContentView: View {
    @State var user = User()
    @State var status: String = "Stopped"
    @State var form: AnyView = AnyView(Rectangle().frame(width: 100, height: 100))
    
    @StateObject private var challengeManager = ChallengeManager.challengeInstance

    var body: some View {
        VStack {
            form
                .foregroundColor(.blue)
                .padding()

            Text("Movement Intensity: \(AccelerationManager.accelerationInstance.motionIntensity, specifier: "%.2f")")
                .font(.subheadline)
            
            Text("\(status)")
                .font(.headline)
                .padding()

            Text("Challenge: \(challengeManager.currentChallenge.isEmpty ? "No challenge..." : challengeManager.currentChallenge)")
                .font(.title)
                .padding()
        }
        .onAppear {
            checkAndStartAccelerometer()
            ChallengeManager.challengeInstance.startChallengeLoop(form: $form, status: $status)
        }
        .onDisappear {
            AccelerationManager.accelerationInstance.stopAccelerometer(form: $form, status: $status)
        }
    }

    func checkAndStartAccelerometer() {
        if challengeManager.currentChallenge.isEmpty {
            AccelerationManager.accelerationInstance.startAccelerometer(form: $form, status: $status)
        } else {
            AccelerationManager.accelerationInstance.stopAccelerometer(form: $form, status: $status)
        }
    }
}

#Preview {
    ContentView()
}
