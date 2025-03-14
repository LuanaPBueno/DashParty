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
    
    @Published var challenges: [Challenge] = [Challenge(name: "Jump")] //MARK: Conjunto de desafios do usuário
    @Published var currentChallenge: String = ""
    
    func startChallengeLoop(form: Binding<AnyView>, status: Binding<String>) {
        Timer.scheduledTimer(withTimeInterval: 15, repeats: true) { _ in
            DispatchQueue.main.async {
                self.currentChallenge = ""

//MARK: -----------------------------------------------------------------------------------------------------
                //MARK: Quero que os desafios aparecam de acordo com a distancia que o usuário já percorreu

                if AccelerationManager.accelerationInstance.totalMotionIntensity >= 15 && AccelerationManager.accelerationInstance.totalMotionIntensity < 30 {
                    AccelerationManager.accelerationInstance.stopAccelerometer(form: form, status: status)
                    if let newChallenge = self.challenges.randomElement() {
                        self.currentChallenge = newChallenge.name
                    }
                }
                
                
                if AccelerationManager.accelerationInstance.totalMotionIntensity >= 30 &&  AccelerationManager.accelerationInstance.totalMotionIntensity < 45 {
                    AccelerationManager.accelerationInstance.stopAccelerometer(form: form, status: status)
                    if let newChallenge = self.challenges.randomElement() {
                        self.currentChallenge = newChallenge.name
                    }
                }
                
                if AccelerationManager.accelerationInstance.totalMotionIntensity >= 45 {
                    AccelerationManager.accelerationInstance.stopAccelerometer(form: form, status: status)
                    if let newChallenge = self.challenges.randomElement() {
                        self.currentChallenge = newChallenge.name
                        //MARK: Ai sai do looping porque o usuário ganhou o game 
                    }
                }
            
//MARK: -----------------------------------------------------------------------------------------------------

                //MARK: Depois de 7 segundos, reinicia o acelerometro e limpa o desafio
                DispatchQueue.main.asyncAfter(deadline: .now() + 7) {
                    self.currentChallenge = ""
                    AccelerationManager.accelerationInstance.startAccelerometer(form: form, status: status)
                }
            }
        }
    }
}
