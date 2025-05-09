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
        ZStack {
            // Fundo
            Image("background")
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()

            // Logo centralizada com animação e dentro da safe area
            VStack {
                Spacer()
                Image("logoBranca")
                    .resizable()
                    .scaledToFit()
                    //.frame(maxWidth: 300)
                    .padding(.horizontal, 46) // respeita laterais
                    //.padding(.top, 16) // respeita topo
                    //.padding(.bottom, 32) // respeita base
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
                Spacer()
            }
        }
    }
}

#Preview {
    InitialView()
}
