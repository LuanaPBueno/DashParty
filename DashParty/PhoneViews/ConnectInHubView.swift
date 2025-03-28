//
//  ConnectInHubView.swift
//  DashParty
//
//  Created by Luana Bueno on 26/03/25.
//

import Foundation
import SwiftUI

struct ConnectInHubView: View{
    @State var navigate : Bool = false
    
    var body : some View{
        
            ZStack{
                    Image("blueBackground")
                    .resizable()
                    .scaledToFill()
                    .frame(maxWidth: .infinity, maxHeight: .infinity)

                
                VStack{
                    Spacer()
                    Text("TO HAVE A BETTER EXPERIENCE CONNECT YOUR PHONE TO A LARGER SCREEN!")
                        .multilineTextAlignment(.center)
                        .font(.largeTitle)
                        .fontWeight(.bold)
                    
                        .padding()
                    
                    VStack {
                        Button(action: {
                            navigate = true
                        }) {
                            Image("buttonConnected")
                        }
                        
                        NavigationLink(
                            destination: NarrativePassingView(),
                            isActive: $navigate,
                            label: { EmptyView() }
                        )
                       
                        .padding()
                        
                        Image("hubs")
                            .fixedSize()
                    }
                    Spacer()
                    
                }
            }
        }
    }


#Preview{
    ConnectInHubView( )
}

