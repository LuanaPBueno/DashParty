//
//  HUBView.swift
//  DashParty
//
//  Created by Luana Bueno on 24/03/25.
//

import Foundation
import SwiftUI

struct FirstHubView: View {
    @StateObject var hubManager = HUBPhoneManager.instance

    var body: some View {
        ZStack {
            if !hubManager.changeScreen {
                Image("chooseLevelHub")
                    .resizable()
                    .scaledToFill()
                    .edgesIgnoringSafeArea(.all)
            } else {
                NarrativeView(multipeerSession: MPCSessionManager.shared)
            }
        }
    }
}
