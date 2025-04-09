//
//  YouWonView.swift
//  DashParty
//
//  Created by Luana Bueno on 28/03/25.
//

import Foundation
import SwiftUI

struct YouWonView: View {
    var interval: TimeInterval
    
    @Environment(\.dismiss) var dismiss
    
    var hubManager = HUBPhoneManager.instance
    
    var formattedTime: String {
        let formatter = DateComponentsFormatter()
        formatter.allowedUnits = [.minute, .second]
        formatter.unitsStyle = .positional
        formatter.zeroFormattingBehavior = .pad
        return formatter.string(from: interval) ?? "00:00"
    }
    
    var body: some View {
        ZStack {
            Image("pinkBackground")
                .resizable()
                .scaledToFill()
                .edgesIgnoringSafeArea(.all)
            
            VStack {
                Text("RACE COMPLETE!")
                    .font(.system(size: 70, weight: .bold, design: .default))
                    .font(.title2)
                
                Text("⎯⎯⎯⎯⎯⎯⎯⎯⎯⎯⎯⎯⎯⎯⎯⎯⎯⎯⎯⎯⎯⎯⎯⎯⎯⎯⎯⎯⎯⎯⎯⎯⎯⎯⎯⎯⎯⎯⎯")
                    .font(.title2)
                
                Text("YOUR FINAL TIME:\n\(formattedTime)")
                    .font(.title)
                
                Text("COME ON! THINK YOU CAN GO FASTER?")
                    .font(.title3)
            }
            .foregroundColor(.white)
            .frame(maxWidth: .infinity, maxHeight: .infinity) // Expande o VStack
           
        }
        .onAppear {
            HUBPhoneManager.instance.endedGame = true
            DispatchQueue.main.async {
//                    self.hubManager.objectWillChange.send()
                }
            if hubManager.newGame {
                DispatchQueue.main.async {
                    dismiss()
                }
            }
        }
    }
}

