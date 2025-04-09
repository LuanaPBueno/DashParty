//
//  Untitled.swift
//  DashParty
//
//  Created by Maria Eduarda Mariano on 08/04/25.
//

import SwiftUI
import CoreMotion

struct HostOrPlayerView: View {
    var multipeerSession : MPCSession!
    
    @State var navigateToHost : Bool = false
    @State var navigateToJoin : Bool = false
    @State var changed: Bool = HUBPhoneManager.instance.changeScreen
    @State private var isActive = false
    
    
    var body: some View {
        
        NavigationStack{
            
            ZStack{
                Image("darkblueBackground")
                    .resizable()
                    .scaledToFill()
                    .ignoresSafeArea()
                
                VStack(alignment: .center, spacing: 10) {
                    
                    Button(action: {
                        navigateToHost = true
                    }) {
                        Image("decorativeRectOrange")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 150, height: 60)
                            .overlay(
                                Text("Host")
                                    .font(.custom("TorukSC-Regular", size: 40))
                                    .foregroundColor(.white)
                            )
                    }
                    
                    NavigationLink(
                        destination: GameDifficulty(multipeerSession: multipeerSession),
                        isActive: $navigateToHost,
                        label: { EmptyView() }
                    )
                    
                    
                    Button(action: {
                        navigateToJoin = true
                    }) {
                        Image("decorativeRectBlue")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 150, height: 60)
                        
                            .overlay(
                                Text("Join")
                                    .font(.custom("TorukSC-Regular", size: 40))
                                    .foregroundColor(.white)
                                
                            )
                    }
                    
                    NavigationLink(
                        destination: RoomsView(multipeerSession: multipeerSession),
                        isActive: $navigateToJoin,
                        label: { EmptyView() }
                    )
                    
                }
                
            }
        }
    }
}


#Preview {
   HostOrPlayerView()
}
