//
//  HUBView.swift
//  DashParty
//
//  Created by Luana Bueno on 24/03/25.
//

import Foundation
import SwiftUI

struct FirstHubView: View {
    @State var hubManager = HUBPhoneManager.instance
    @State var audioManager: AudioManager = AudioManager()


    var body: some View {
        ZStack {
            if !hubManager.changeScreen {
                Image("chooseLevelHub")
                    .resizable()
                    .scaledToFill()
                    .edgesIgnoringSafeArea(.all)
                Text("Choose level hub") //MARK: TIRAR
            } else {
                NarrativeView()
                Text("Narrative view") //MARK: TIRAR
            }
        }
    }
}
