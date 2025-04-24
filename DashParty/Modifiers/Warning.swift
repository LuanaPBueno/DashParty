//
//  Warning.swift
//  DashParty
//
//  Created by Fernanda Auler on 17/04/25.
//

import SwiftUI

struct Warning: View {
    @State var currentChallenge:String
    var body: some View {
        Image("warning")
            .overlay {
                Text(currentChallenge)
            }
    }
}

#Preview {
    Warning(currentChallenge: "Run!")
}
