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
    
            VStack {

                Image("tutorialRectangle")
                    .overlay(
                        HStack(alignment: .top, spacing: 0) {
                            Image(tutorialImage)
                               
                                .frame(width: 400, height: 500) // ou o tamanho desejado
                               
                            
                            VStack(alignment: .leading, spacing: 30) {
                                Text(tutorialTextTitle)
                                    .font(.custom("TorukSC-Regular", size: 50, relativeTo: .title))
                                    .foregroundStyle(.lowOpacityText)
                                   
                                    .padding(.top, 120)
                                
                            
                                Image("tutorialLine")
                                
                                Text(tutorialText)
                                    .font(.custom("Wonder-Light", size: 34, relativeTo: .body))
                                    .multilineTextAlignment(.leading)
                                    .foregroundStyle(.text)
                                 
                                    .frame(width: 500, height: 100)
                            }
                            .padding(.leading, 0)
                        }
                    )
            }
    }
}

#Preview {
    TutorialSheet(tutorialImage: "tutorialImage1", tutorialText: "Keep your phone in a vertical position throughout the race.", tutorialTextTitle: "Run")
}
