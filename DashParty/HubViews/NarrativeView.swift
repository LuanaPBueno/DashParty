//
//  NarrativeView.swift
//  DashParty
//
//  Created by Luana Bueno on 24/03/25.
//

import Foundation
import SwiftUI

struct NarrativeView: View {
    @State var narrativeText: [[String : Bool]] = [["A cada geração, a floresta Aru escolhe seu líder...": false], ["Essa liderança não se ganha com discursos ou promessas...": false], ["Mas com uma corrida!": false], ["A trilha desafia todos  que ousam disputá-la. Ela não é apenas um caminho – ela é viva. Cheia de armadilhas, desafios e mistérios.": false],["Hora da grande corrida! Quem está pronto para perder?": true ], ["A corrida não é só velocidade, Bongo. É sobre estratégia, inteligência e—": true], ["—E não ser esmagado por um urso gigante?": true], ["Ei! Talvez o segredo seja… passar por cima da concorrência!": true], ["Prefiro ser devorado por um lobo!": true], ["Se vocês terminaram de discutir, podemos começar? A floresta nos espera.": true], ["Quatro competidores, um único trono. A terra treme. As folhas sussurram. A corida começa...": false], ["Agora!": false]] //MARK: Esse verdadeiro ou falso é se tem um personagem falando. Se tiver, vai ter um estilo diferente.
    
    @State var currentText: Int = 0
    @State var terminateNarrative: Bool = false
    
    var body: some View {
        
        ZStack{
            if narrativeText[currentText].values.first == true {
                withCharacter()
            } else {
                withoutCharacter()
            }
            
            VStack {
                HStack {
                    Spacer()
                    Image("narrativeSkipButton")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 150)
                }
                Spacer()
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
        VStack{
            ZStack{
                Image("narrativeTextBackground")
                    .resizable()
                    .scaledToFit()
                    .padding(.trailing, 30)
                    .padding(.leading, 30)
                
                VStack {
                    Text(narrativeText[currentText].keys.first ?? "")
                        .foregroundColor(.black)
                        .font(.custom("Prompt-Regular", size: 30))
                        .multilineTextAlignment(.center)
                        .frame(maxWidth: 1000)
                    
                    HStack{
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
                                .frame(maxWidth: 50)
                                .padding(.trailing, 10)
                            
                        }
                    }
                }
                
            }
        }
    }
    
    
    
    private func withCharacter() -> some View {
        VStack{
            Spacer().frame(height: 40)
          
            Image("characters")
                .resizable()
                .scaledToFit()
                .padding(.trailing, 30)
                .padding(.leading, 30)
                .padding(.bottom, 400)
           
            ZStack{
                Image("narrativeTextBackground")
                    .resizable()
                    .scaledToFit()
                    .padding(.trailing, 30)
                    .padding(.leading, 30)
                
                VStack {
                    Text(narrativeText[currentText].keys.first ?? "")
                        .foregroundColor(.black)
                        .font(.custom("Prompt-Regular", size: 30))
                        .multilineTextAlignment(.center)
                    
                    
                    HStack{
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
                                .padding(.trailing, 10)
                            
                        }
                    }
                }
                
            }
        }
    }
}

    

#Preview{
    NarrativeView( )
}



