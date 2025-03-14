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
    @State var form: AnyView = AnyView(Image("orangePerson"))
    @State private var moveBackground = false
    
    @StateObject private var challengeManager = ChallengeManager.challengeInstance

    var body: some View {
        ZStack{
            Image("matchBackground")
                .resizable()
                .scaledToFill()
                .edgesIgnoringSafeArea(.all)
            //MARK: Teoricamente era para movimentar a tela de fundo?:
                .offset(y: moveBackground ? 20 : -20)
                .animation(status == "form" ?
                    Animation.easeInOut(duration: 1).repeatForever(autoreverses: true)
                    : .default, value: moveBackground)
            //MARK: --------------------------------------------------
            
            VStack {
                Text("\(status)")
                    .font(.system(size: status == "Jumping" ? 120 : 90))
                    .padding()
                
                form
                    .foregroundColor(.blue)
                    .padding()
                
                Text("Movement Intensity: \(AccelerationManager.accelerationInstance.motionIntensity, specifier: "%.2f")")
                    .font(.subheadline)
                
                Text("Challenge: \(challengeManager.currentChallenge.isEmpty ? "No challenge..." : challengeManager.currentChallenge)")
                    .font(.title)
                
                    .padding()
            }
            .onAppear {
                checkAndStartAccelerometer() //MARK: Inicia o acelerometro
                ChallengeManager.challengeInstance.startChallengeLoop(form: $form, status: $status) //MARK: Inicia a func que vai dar desafios aleatórios para os usuários
            }
            .onDisappear {
                AccelerationManager.accelerationInstance.stopAccelerometer(form: $form, status: $status) //MARK: Desliga o acelerometro
            }
        }
    }

    func checkAndStartAccelerometer() {
        if challengeManager.currentChallenge.isEmpty { //MARK: Se não tem nenhum desafio no momento, começa o acelerômetro. Se não, para ele.
            AccelerationManager.accelerationInstance.startAccelerometer(form: $form, status: $status)
        } else {
            AccelerationManager.accelerationInstance.stopAccelerometer(form: $form, status: $status)
        }
    }
}

#Preview {
    ContentView()
}
