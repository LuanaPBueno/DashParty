//
//  CharacterView.swift
//  DashParty
//
//  Created by Maria Eduarda Mariano on 23/03/25.
//

import SwiftUI
import CoreMotion

struct CharacterView: View {
    var body: some View{
        ZStack{
            Image("blueBackground")
            VStack{
                Image("comandCharacter")
                Image("startButton")
            }
        }
    }
}

#Preview {
    CharacterView()
}
