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
                        HStack(alignment: .center, spacing: 0) {
                            Image(tutorialImage)
                               
                                .frame(width: 400, height: 400)
                            VStack(alignment: .leading, spacing: 30) {
                                Text(tutorialTextTitle)
                                    .font(.custom("TorukSC-Regular", size: 50, relativeTo: .title))
                                    .foregroundStyle(.lowOpacityText)
                                   
                                    //.padding(.top, 120)
                                
                            
                                Image("tutorialLine")
                                
                                Text(tutorialText)
                                    .font(.custom("Wonder-Light", size: 34, relativeTo: .body))
                        
                                    .foregroundStyle(.text)
                                    
                                    .frame(width: 580)
                                    .offset(x: tutorialImage == "tutorialImage6" ? -30 : 0, y: 0)
                                
                            }
                            //.padding(.leading, 0)
                        }
                    )
            }
    }
}

#Preview {
    TutorialSheet(tutorialImage: "tutorialImage3", tutorialText: "Keep your phone in a vertical position throughout the race.", tutorialTextTitle: "Run")
}
