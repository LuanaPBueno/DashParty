//
//  ConnectInHubView.swift
//  DashParty
//
//  Created by Luana Bueno on 26/03/25.
//

import Foundation
import SwiftUI

struct ConnectInHubView: View{
    var multipeerSession : MPCSession!
    @State var navigate : Bool = false
    
    var body : some View{
        
        ZStack{
            Image("blueBackground")
            
          
            VStack{
                Text("TO HAVE A BETTER EXPERIENCE CONNECT \n YOUR PHONE TO A LARGER SCREEN!")
                    .fontWeight(.black)
                    .multilineTextAlignment(.center)
                    .padding(.bottom, 50)
                    .font(.largeTitle)
                    .font(.system(size: 80, weight: .regular, design: .default))

                    
                
                Button(action: {
                    navigate = true
                }) {
                    Image("buttonConnected")

                }
                
                NavigationLink(
                    destination: NarrativePassingView(multipeerSession: multipeerSession),
                    isActive: $navigate,
                    label: { EmptyView() }
                )
                
                
                Image("hubs")
                    .resizable()
                    .scaledToFit()
                    .frame(maxWidth: 400)
                    .padding(.horizontal)
                    .padding(.top, 50)

                    
            }
        }
    }
}
    

   

#Preview{
    ConnectInHubView( )
}

