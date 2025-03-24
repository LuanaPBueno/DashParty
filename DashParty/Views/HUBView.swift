//
//  HUBView.swift
//  DashParty
//
//  Created by Luana Bueno on 24/03/25.
//

import Foundation
import SwiftUI

struct ExternalDisplayView: View {
    var body: some View {
        ZStack{
            Color(.white)
            Text("Hello, world!")
                .font(.system(size: 96, weight: .bold))
                .foregroundStyle(.black)
        }
        .ignoresSafeArea()
        .scaledToFill()
    }

}
