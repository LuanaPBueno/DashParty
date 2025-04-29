//
//  CharacterView.swift
//  DashParty
//
//  Created by Maria Eduarda Mariano on 23/03/25.
//

import SwiftUI
import CoreMotion

enum Clan: String, CaseIterable, Identifiable, Codable, Hashable {
    case bunny, monkey, feline, frog
    
    var id: String { self.rawValue }

    var image: Image {
        switch self {
        case .bunny: return Image("clanBunny")
        case .monkey: return Image("clanMonkey")
        case .feline: return Image("clanFeline")
        case .frog: return Image("clanFrog")
        }
    }
}

struct CharacterView: View {
    var multipeerSession = MPCSessionManager.shared
    
    @State private var tempSelection: Clan?
    @State private var navigateToNext = false
    
    var body: some View {
     
            ZStack {
                Image("purpleBackground")
                    .resizable()
                    .scaledToFill()
                    .ignoresSafeArea()
                
                VStack {
                    Spacer()
                    
                    Text("Choose your guardian")
                        .font(.custom("TorukSC-Regular", size: 28))
                        .foregroundColor(.white)
                    
                    Spacer()
                    
                    HStack {
                        
                        ForEach(Clan.allCases) { clan in
                            ClanCard(clan: clan, isSelected: tempSelection == clan)
                                .onTapGesture {
                                    tempSelection = clan
                                }
                        }
                        
                    }
                    
                    
                    Spacer()
                    HStack{
                        Spacer()
                    Button(action: {
                        multipeerSession.selectedClans[multipeerSession.myDisplayName] = tempSelection
                        //router = .algumCasoAi
                    }) {
                        
                        ZStack {
                                Image("decorativeRectOrange")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 160, height: 55) // 📏 tamanho só do botão, sem afetar o resto
                                Text("Done")
                                    .font(.custom("TorukSC-Regular", size: 20))
                                    .foregroundColor(.white)
                            }
                    
                }
                      
                    }
                    .padding(.trailing, 20)
                    .disabled(tempSelection == nil)
                    .opacity(tempSelection == nil ? 0.5 : 1.0)
                }
            }
        
    }
}

struct ClanCard: View {
    let clan: Clan
    let isSelected: Bool

    var body: some View {
        ZStack {
            clan.image
              
                
            if isSelected {
                Image("faixaAmarela")
                    .padding(.top, 133)
            }
        }
    }
}

#Preview {
    CharacterView(multipeerSession: MPCSessionManager.shared)
}
