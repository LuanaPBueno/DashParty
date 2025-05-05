//
//  TutorialSheet.swift
//  DashParty
//
//  Created by Fernanda Auler on 25/04/25.
//

import SwiftUI

struct TutorialSheet: View {
    var tutorialImage:String
    var tutorialText:String
    var tutorialTextTitle:String
    var body: some View {
       // ZStack {
//            Image("backgroundPurple")
//                .resizable()
//                .scaledToFill()
//                .ignoresSafeArea()
            VStack {
                VStack(spacing: 5) {
                    Text("Heads Up!")
                        .font(.custom("TorukSC-Regular", size: 70, relativeTo: .largeTitle))
                        .multilineTextAlignment(.center)
                        .foregroundColor(.white)

                    Text("Things make way more sense after the tutorial...")
                        .font(.custom("TorukSC-Regular", size: 50, relativeTo: .title))
                        .multilineTextAlignment(.center)
                        .foregroundColor(.white)
                }
                .padding(.top, 5) // esse valor ajusta o quão para cima o título vai

                //Spacer(minLength: 20)

                Image("tutorialRectangle")
                    .overlay(
                        HStack(alignment: .top, spacing: 20) {
                            Image(tutorialImage)
                            VStack(alignment: .leading, spacing: 12) {
                                Text(tutorialTextTitle)
                                    .font(.custom("TorukSC-Regular", size: 50, relativeTo: .title))
                                    .foregroundStyle(.lowOpacityText)
                                Image("tutorialLine")
                                Text(tutorialText)
                                    .font(.custom("Wonder-Light", size: 34, relativeTo: .body))
                                    .multilineTextAlignment(.leading)
                                    .foregroundStyle(.text)
                            }
                            .padding(.leading, 40)
                        }
                    )

               // Spacer()
            }
       // }
    }
}

#Preview {
    TutorialSheet(tutorialImage: "tutorialImage1", tutorialText: "Keep your phone in a vertical position throughout the race.", tutorialTextTitle: "Run")
}
