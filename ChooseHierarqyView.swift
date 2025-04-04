//
//  ChooseHierarqyView.swift
//  DashParty
//
//  Created by Luana Bueno on 31/03/25.
//

import Foundation
import SwiftUI

struct ChooseHierarchyView : View {
    
    @State var navigate : Bool = false
    @State var multipeerSession = MPCSessionManager.shared //criando session
    var body : some View{
        VStack{
            Button {
                print("Host button tapped")
                MPCSessionManager.shared.host = true
                MPCSessionManager.shared.start()
                navigate = true
                multipeerSession.start() // Certifique-se de chamar start() para iniciar a conexão
            } label: {
                Text("Host")
            }
            
            Button {
                print("Player button tapped")
                MPCSessionManager.shared.host = false
                MPCSessionManager.shared.start()
                navigate = true
                MPCSessionManager.shared.start() // Certifique-se de chamar start() para começar a busca por peers
            } label: {
                Text("Player")
            }
        }
        .navigationDestination(isPresented: $navigate) {
            RoomView(multipeerSession: multipeerSession)
        }
        
      


    }
}
