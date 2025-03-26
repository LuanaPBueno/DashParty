//
//  HUBPhoneManager.swift
//  DashParty
//
//  Created by Luana Bueno on 24/03/25.
//

import Foundation
import SwiftUI

class HUBPhoneManager: ObservableObject {
    static let instance = HUBPhoneManager()
    
    @Published var narrativeText: [[String : Bool]] = [
        ["A cada geração, a floresta Aru escolhe seu líder...": false],
        ["Essa liderança não se ganha com discursos ou promessas...": false],
        ["Mas com uma corrida!": false],
        ["A trilha desafia todos que ousam disputá-la. Ela não é apenas um caminho – ela é viva. Cheia de armadilhas, desafios e mistérios.": false],
        ["Hora da grande corrida! Quem está pronto para perder?": true],
        ["A corrida não é só velocidade, Bongo. É sobre estratégia, inteligência e—": true],
        ["—E não ser esmagado por um urso gigante?": true],
        ["Ei! Talvez o segredo seja… passar por cima da concorrência!": true],
        ["Prefiro ser devorado por um lobo!": true],
        ["Se vocês terminaram de discutir, podemos começar? A floresta nos espera.": true],
        ["Quatro competidores, um único trono. A terra treme. As folhas sussurram. A corrida começa...": false],
        ["Agora!": false]
    ]
    
    @Published var passToTutorialView: Bool = false
    
    @Published var actualPage: Int = 0
    
    @Published var changeScreen: Bool = false
    
    @Published var actualTutorialIndex: Int = 0
    
    private init() {}
}
