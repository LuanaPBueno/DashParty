//
//  ContentView.swift
//  DashParty
//
//  Created by Luana Bueno on 11/03/25.
//

import SwiftUI
import CoreMotion

struct ContentView: View {
    @Binding var router: Router
    
    @State var navigate : Bool = false
    @State var changed: Bool = HUBPhoneManager.instance.changeScreen
    @State private var isActive = false
    
    var body: some View {
            ZStack{
                Image("illustrationTitle")
                    .resizable()
                    .scaledToFill()
                    .ignoresSafeArea()
                
                Text("©2025")
                    .font(.custom("TorukSC-Regular", size: 14))
                    .textCase(.uppercase)
                    .foregroundColor(.white)
                    .offset(x: -350, y: 170)
                
                Text("ver. 1.2.1")
                    .font(.custom("TorukSC-Regular", size: 14))
                    .textCase(.uppercase)
                    .foregroundColor(.white)
                    .offset(x: 350, y: 170)
                
                VStack {
                    Spacer()
                    Image("logoBranca")
                        .resizable()
                        .scaledToFit()
                        //.frame(maxWidth: 500)
                        .padding(.top, 40)
                        .padding(40)
                    
                    Spacer()

                    HStack(alignment: .center){
                        Spacer()
                        Button(action: {
                            router = .play
                        }) {
                            OrangeButtonPhone(text: "Play", sizeFont: 28)
                                .frame(width:220, height: 69)

                        }
//                        HStack(alignment: .center){
//                            Button(action: {
//                                router = .options
//                            }) {
//                                OrangeButtonPhone(text: "Options", sizeFont: 28)
//                                    .padding(.vertical, 60)
//                                    
//
//                            }
//                            
//                        }
                        Spacer()
                    }
                    Spacer()
                    Spacer()
                }
            }
            
        
    }
}


#Preview {
    ContentView(router: .constant(.start))
}
