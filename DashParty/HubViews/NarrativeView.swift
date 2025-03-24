//
//  NarrativeView.swift
//  DashParty
//
//  Created by Luana Bueno on 24/03/25.
//

import Foundation
import SwiftUI

struct NarrativeView: View {
    @State var narrativeText: [[String : Bool]] = [["A cada geração, a floresta Aru escolhe seu líder...": false], ["Essa liderança não se ganha com discursos ou promessas...": false], ["Mas com uma corrida!": false], ["E quem ganha, vive!": false], ["A trilha se transforma, desafiando aqueles que ousam disputá-la. Ela não é apenas um caminho – ela é viva. Cheia de armadilhas, desafios e mistérios escondidos.": true]] //MARK: Esse verdadeiro ou falso é se tem um personagem falando. Se tiver, vai ter um estilo diferente.
    
    @State var currentText: Int = 0
    @State var terminateNarrative: Bool = false
    
    var body: some View {
        
        ZStack{
            Image("narrativeBackground")
                .resizable()
                .scaledToFill()
                .edgesIgnoringSafeArea(.all)
            
            
            VStack{
                Image("narrativeSkipButton")
                    .frame(width: 100, height: 100)
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topTrailing)
                    .padding(.top, 20)
                    .padding(.trailing, 40)
                
                if let secondKey = Array(narrativeText[currentText].keys).dropFirst().first {
                    withCharacter()
                } else {
                    withoutCharacter()
                }

            }
        }
       
    }
    
    private func withoutCharacter() -> some View {
        VStack{
            ZStack{
                Image("narrativeTextBackground")
                    .padding(.bottom, 350)
                    .frame(maxWidth: 1280)
                
                VStack {
                    Text(narrativeText[currentText].keys.first ?? "")
                        .foregroundColor(.black)
                        .foregroundColor(.black)
                        .font(.custom("Prompt-Regular", size: 25))
                        .font(.system(size: 22, weight: .medium))
                        .multilineTextAlignment(.center)
                        .padding(.bottom, 30)
                    
                    HStack{
                        Spacer()
                        Button {
                            if currentText == narrativeText.count-1 {
                                terminateNarrative = true
                            }else{
                                currentText+=1
                            }
                        } label: {
                            Image("nextNarrativeButton")
                                .resizable()
                                .scaledToFit()
                                .frame(maxWidth: 50)
                                .padding(.trailing, 100)
                                .padding(.bottom, 300)
                        }
                        
                        
                    }
                }
            }
        }
    }
    
    private func withCharacter() -> some View {
        Text("Hi")
    }
}

#Preview{
    NarrativeView()
}
