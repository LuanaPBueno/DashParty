//
//  Challenges .swift
//  DashParty
//
//  Created by Luana Bueno on 11/03/25.
//

import Foundation
import SwiftUI

class ChallengeManager: ObservableObject {
    static let challengeInstance = ChallengeManager()
    
    @Published var challenges: [Challenge] = [Challenge(name: "Jump"), Challenge(name: "Spin")]
    @Published var currentChallenge: String = ""
    
    func startChallengeLoop(form: Binding<AnyView>, status: Binding<String>) {
        Timer.scheduledTimer(withTimeInterval: 15, repeats: true) { _ in
            DispatchQueue.main.async {
                self.currentChallenge = ""
                print("nome limpo")

                DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
                    AccelerationManager.accelerationInstance.stopAccelerometer(form: form, status: status)
                    if let newChallenge = self.challenges.randomElement() {
                        self.currentChallenge = newChallenge.name
                        print("\(self.currentChallenge)")
                    }
                }

                DispatchQueue.main.asyncAfter(deadline: .now() + 10) {
                    self.currentChallenge = ""
                    AccelerationManager.accelerationInstance.startAccelerometer(form: form, status: status)
                }
            }
        }
    }
}
