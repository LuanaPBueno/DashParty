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
            Image("backgroundPhone")
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()
            VStack{
                HStack{
                    Button {
                        multipeerSession.mcSession.disconnect()
                        router = .matchmaking
                    } label: {
                        Image("backButton")
                            .padding(.leading, 35)
                            .padding(.top, 35)
                    }
                    Spacer()
                }
                Spacer()
            }
            VStack{
                Spacer()
                Text("Ready?")
                    .font(.custom("TorukSC-Regular", size: 45, relativeTo: .title))
                    .foregroundColor(.white)
                    .multilineTextAlignment(.center)
                //Spacer()
                HStack (spacing: 20){
                    Image("hub")
                    Text("To set up your game, share your screen via AirPlay!")
                        .font(.custom("TorukSC-Regular", size: 35))
                        .foregroundColor(.white)
                        .multilineTextAlignment(.leading)
                }
                .padding(.horizontal, 80)
                .multilineTextAlignment(.center)
                //Spacer()
                Text("We recommend these screens")
                    .font(.custom("TorukSC-Regular", size: 15))
                    .foregroundColor(.white)
                    .padding(.top, 20)
                Image("hubs")
                Spacer()
            }
               
               // .padding(.vertical, 40)

            VStack {
                Spacer()
                Button {
                    router = .matchmaking
                } label: {
                    OrangeButtonPhone(text: "Ready", sizeFont: 20)
                        .frame(width: 150, height: 45) // controla o tamanho do botão
                }
                .frame(maxWidth: .infinity, alignment: .trailing) // joga o botão pra direita
                .padding(.trailing, 35) // encosta ele na direita, mas com uma margem de 40
                .padding(.bottom, 20) // opcional: dar uma afastada da borda inferior
            }
            
        }
    }
}

#Preview {
    ReadyView(router: .constant(.airplayInstructions))
}
