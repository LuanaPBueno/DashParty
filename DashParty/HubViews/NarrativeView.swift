//
//  NarrativeView.swift
//  DashParty
//
//  Created by Luana Bueno on 24/03/25.
//

import Foundation
import SwiftUI

import Foundation
import SwiftUI

struct NarrativeView: View {
    @ObservedObject var hubManager = HUBPhoneManager.instance

    var body: some View {
        ZStack {
            if hubManager.actualPage < hubManager.narrativeText.count {
                if hubManager.narrativeText[hubManager.actualPage].values.first == true {
                    withCharacter()
                } else {
                    withoutCharacter()
                }
            } else {
                Text("Fim da narrativa!")
                    .font(.custom("Prompt-Regular", size: 30))
                    .foregroundColor(.black)
                    .multilineTextAlignment(.center)
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background {
            Image("narrativeBackground")
                .resizable()
                .scaledToFill()
                .edgesIgnoringSafeArea(.all)
        }
    }

    private func withoutCharacter() -> some View {
        VStack {
            ZStack {
                Image("narrativeTextBackground")
                    .resizable()
                    .scaledToFit()
                    .padding(.horizontal, 30)

                VStack {
                    Text(hubManager.narrativeText[hubManager.actualPage].keys.first ?? "")
                        .foregroundColor(.black)
                        .font(.custom("Prompt-Regular", size: 25))
                        .multilineTextAlignment(.center)
                        .padding(.leading, 50)
                        .padding(.trailing, 50)
                        .padding(.top, 50)

                    
                    HStack{
                        Spacer()
                        Button {
                            if currentText == narrativeText.count-1 {
                               currentText = 0
                            }else{
                                currentText+=1
                            }
                        } label: {
                            Image("nextNarrativeButton")
                                .resizable()
                                .scaledToFit()
                                .frame(maxWidth: 40)
                                .padding(.trailing, 40)
                                
                        }
                    }
                }
            }
        }
    }

    private func withCharacter() -> some View {
        VStack {
            Spacer().frame(height: 40)
        
            Image("characters")
                .resizable()
                .scaledToFit()
                .padding(.horizontal, 30)
                .padding(.bottom, 400)
        
            ZStack{
                Image("narrativeTextBackground")
                    .resizable()
                    .scaledToFit()
                    .padding(.horizontal, 30)

                VStack {
                    Text(hubManager.narrativeText[hubManager.actualPage].keys.first ?? "")
                        .foregroundColor(.black)
                        .font(.custom("Prompt-Regular", size: 30))
                        .multilineTextAlignment(.center)
                }
            }
        }
    }
}


#Preview{
    NarrativeView( )
}



