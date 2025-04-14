//
//  InitialView.swift
//  DashParty
//
//  Created by Fernanda Auler on 12/04/25.
//

import SwiftUI

struct InitialView: View {
    @State private var breathe = false
    var body: some View {
        ZStack {
            Image("backgroundFill")
                .resizable()
                .ignoresSafeArea()
                .scaledToFill()
            Image("logoBranca")
                .resizable()
                .scaledToFit()
                //.frame(maxWidth: 300)
                .scaleEffect(breathe ? 1.05 : 0.95)
                .opacity(breathe ? 1.0 : 0.7)
                .animation(
                    .easeInOut(duration: 1.5)
                    .repeatForever(autoreverses: true),
                    value: breathe
                )
                .onAppear {
                    breathe = true
                }
            
            
        }
    }
}

#Preview {
    InitialView()
}
