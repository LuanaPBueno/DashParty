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
    @State var multipeerSession = MPCSession(service: "nisample", identity: "Luana-Bueno.DashParty", maxPeers: 3) //criando session
    var body : some View{
        VStack{
            Button {
                print("Host button tapped")
                multipeerSession.host = true
                navigate = true
                multipeerSession.start() // Certifique-se de chamar start() para iniciar a conexão
            } label: {
                Text("Host")
            }
            
            Button {
                print("Player button tapped")
                multipeerSession.host = false
                navigate = true
                multipeerSession.start() // Certifique-se de chamar start() para começar a busca por peers
            } label: {
                Text("Player")
            }
        }
        .navigationDestination(isPresented: $navigate) {
            RoomView(multipeerSession: multipeerSession)
        }
        
      


    }
}
