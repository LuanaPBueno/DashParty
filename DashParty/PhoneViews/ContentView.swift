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

                VStack {
                    Spacer()
                    Image("logoBranca")
                        .resizable()
                        .scaledToFit()
                        //.frame(maxWidth: 500)
                        .padding(.top, 40)
                    
                    HStack(alignment: .center){
                        Spacer()
                        Button(action: {
                            router = .play
                        }) {
                            OrangeButtonPhone(text: "Play", sizeFont: 28)
                                .padding(.vertical, 60)
                                
                        }
                        .padding(.trailing, 10)
                        
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
                }
            }
            
        
    }
}


#Preview {
    ContentView(router: .constant(.start))
}
