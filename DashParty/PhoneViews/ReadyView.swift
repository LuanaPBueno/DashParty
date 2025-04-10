//
//  ReadyView.swift
//  DashParty
//
//  Created by Maria Eduarda Mariano on 09/04/25.
//

import SwiftUI
import CoreMotion

struct ReadyView: View {
    
    var multipeerSession : MPCSession!
    
    @State var navigate : Bool = false
    @State var changed: Bool = HUBPhoneManager.instance.changeScreen
    @State private var isActive = false
    
    var body: some View {
        NavigationStack{
            ZStack{
                Image("purpleBackground")
                    .resizable()
                    .scaledToFill()
                    .ignoresSafeArea()
                
                VStack{
                    
                    Spacer()
                    
                                        
                        Text("to set up your game, share \n your screen via AirPlay!")
                            .font(.custom("TorukSC-Regular", size: 30))
                            .foregroundColor(.white)
                            .multilineTextAlignment(.center)
                    
                    Spacer()
                    
                    Text("we recommend these screens")
                        .font(.custom("TorukSC-Regular", size: 20))
                        .foregroundColor(.white)
                    
                    Image("hubs")
                    Spacer()
                    
                    Button(action: {
                        navigate = true
                    }) {
                        Image("decorativeRectOrange")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 150, height: 60)
                            .overlay(
                                Text("Ready")
                                    .font(.custom("TorukSC-Regular", size: 28))
                                    .foregroundColor(.white)
                            )
                    }
                    
                    NavigationLink(
                        destination: NarrativePassingView(),
                      //  destination: ChooseHierarchyView(),
                        isActive: $navigate,
                        label: { EmptyView() }
                    )
                    
                    Spacer()
                }
                
            }
            
        }
    }
}

#Preview {
    ReadyView()
}
