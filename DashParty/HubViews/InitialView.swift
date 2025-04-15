//
//  InitialView.swift
//  DashParty
//
//  Created by Fernanda Auler on 12/04/25.
//

import SwiftUI

struct InitialView: View {
    @State private var breathe = true
    @State private var showCustomAlert = true

    var body: some View {
        GeometryReader { geometry in
            ZStack {
                // Fundo
                Image("backgroundFill")
                    .resizable()
                    .ignoresSafeArea()
                    .scaledToFill()

                // Logo animada
                Image("logoBranca")
                    .resizable()
                    .scaledToFit()
                    .frame(maxWidth: geometry.size.width * 0.8)
                    .scaleEffect(breathe ? 1.1 : 0.95)
                    .opacity(breathe ? 1.0 : 0.8)
                    .onAppear {
                        withAnimation(
                            .easeInOut(duration: 1.6)
                                .repeatForever(autoreverses: true)
                        ) {
                            breathe.toggle()
                        }
                    }
                
                

                // Alerta Customizado
//                if showCustomAlert {
//                    ZStack {
//                        Image("rectangleWarning")
//                            .resizable()
//                            .scaledToFit()
//                            .overlay(
//                                GeometryReader { alertGeo in
//                                    VStack(spacing: alertGeo.size.height * 0.04) {
//                                        Text("Reminder")
//                                            .font(.custom("TorukSC-regular", size: alertGeo.size.width * 0.07))
//                                            .foregroundColor(.black)
//                                            .multilineTextAlignment(.center)
//                                            .lineLimit(1)
//                                            .minimumScaleFactor(0.5)
//
//                                        Text("The host is the one who should be sharing the screen.")
//                                            .font(.custom("Wonder-Light", size: alertGeo.size.width * 0.05))
//                                            .foregroundColor(.black)
//                                            .multilineTextAlignment(.center)
//                                            .lineLimit(3)
//                                            .minimumScaleFactor(0.5)
//                                            .padding(.horizontal, alertGeo.size.width * 0.05)
//
////                                        Button(action: {
////                                            withAnimation {
////                                                showCustomAlert = false
////                                            }
////                                        }) {
////                                            ContinueButton(
////                                                text: "Ok",
////                                                sizeFont: Int(alertGeo.size.width * 0.03) // fonte menor
////                                            )
////                                            .frame(maxWidth: alertGeo.size.width * 0.18) // restringe largura total do botão
////                                        }
//                                    }
//                                    .frame(width: alertGeo.size.width, height: alertGeo.size.height)
//                                }
//                            )
//                    }
//                    .frame(width: geometry.size.width * 0.8) // Tamanho do alerta como um todo
//                }
            }
        }
    }
}

#Preview {
    InitialView()
}
