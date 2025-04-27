//
//  ReadyView.swift
//  DashParty
//
//  Created by Maria Eduarda Mariano on 09/04/25.
//

import SwiftUI
import CoreMotion

struct ReadyView: View {
    @Binding var router:Router
    var multipeerSession : MPCSession!
    
    @State var navigate : Bool = false
    @State var changed: Bool = HUBPhoneManager.instance.changeScreen
    @State private var isActive = false
    
    var body: some View {
        ZStack{
            Image("purpleBackground")
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()
            
            VStack{
                HStack{
                    Button {
                        router = .play
                    } label: {
                        Image("backButton")
                            .padding(.leading, 56)
                            .padding(.top, 44)

                    }
                    Spacer()
                }
                Text("Ready?")
                    .font(.custom("TorukSC-Regular", size: 45, relativeTo: .title))
                    .foregroundColor(.white)
                    .multilineTextAlignment(.center)
                Spacer()
                HStack (spacing: 20){
                    Image("hub")
                    Text("To set up your game, share your screen via AirPlay!")
                        .font(.custom("TorukSC-Regular", size: 35))
                        .foregroundColor(.white)
                        .multilineTextAlignment(.leading)
                }
                .padding(.horizontal, 80)
                .multilineTextAlignment(.center)
                Spacer()
                Text("We recommend these screens")
                    .font(.custom("TorukSC-Regular", size: 15))
                    .foregroundColor(.white)
                Image("hubs")
                
                
                
                
            }
        }
    }
}

#Preview {
    ReadyView(router: .constant(.airplayInstructions))
}
