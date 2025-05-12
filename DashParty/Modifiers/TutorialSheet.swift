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
                
                //Spacer(minLength: 20)

                Image("tutorialRectangle")
//                    .resizable()
                    .scaledToFit()
                    .overlay(
                        HStack(alignment: .top, spacing: 20) {
                            Image(tutorialImage)
//                               .resizable()
                                .scaledToFit()
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
                            .padding()
                    )
                    .clipped()
               // Spacer()
            }
       // }
    }
}

#Preview {
    TutorialSheet(tutorialImage: "tutorialImage1", tutorialText: "Keep your phone in a vertical position throughout the race.", tutorialTextTitle: "Run")
}
