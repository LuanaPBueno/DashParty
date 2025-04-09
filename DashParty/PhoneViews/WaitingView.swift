//
//  ConnectInHubView.swift
//  DashParty
//
//  Created by Luana Bueno on 26/03/25.
//

import Foundation
import SwiftUI

struct WaitingView: View{
    
    var multipeerSession : MPCSession!
    @State var navigate : Bool = false
    @State var changed: Bool = HUBPhoneManager.instance.changeScreen
    @State private var isActive = false
    
    
    var body : some View{
        
        NavigationStack{
            ZStack{
                Image("purpleBackground")
                    .resizable()
                    .scaledToFill()
                    .ignoresSafeArea()
            
                VStack{
                    Spacer()
                    
                    Text("Waiting for players to join...")
                        .multilineTextAlignment(.center)
                        .font(.custom("TorukSC-Regular", size: 40))
                        .foregroundColor(.white)
                    
                    Spacer()
                    
                    HStack{
                    Image("hostPhone")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 200, height: 200)
                    
                }
                    Spacer()
                    
                  Button(action: {
                        navigate = true
                    }) {
                        Image("decorativeRectOrange")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 100, height: 50)
                            .overlay(
                                Text("Continue")
                                    .font(.custom("TorukSC-Regular", size: 20))
                                    .foregroundColor(.white)
                            )
                    }
                    

                    NavigationLink(
                        destination: CharacterView(multipeerSession: multipeerSession),
                        isActive: $navigate,
                        label: { EmptyView() }
                    )
                    
             
                    
                }
                .navigationDestination(isPresented: $isActive) {
                }
                
                Spacer()
            }
        }
    }
}

#Preview{
    WaitingView( )
}

