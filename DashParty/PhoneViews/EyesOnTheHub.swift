//
//  EyesOnTheHub.swift
//  DashParty
//
//  Created by Fernanda Auler on 12/04/25.
//

import SwiftUI

struct EyesOnTheHub: View {
    var body: some View {
        Image("eyesOnTheHub")
            .resizable()
            .frame(width: UIScreen.main.bounds.width * 1.1)
            .scaledToFill()
            .ignoresSafeArea()
    }
}

#Preview {
    EyesOnTheHub()
}
