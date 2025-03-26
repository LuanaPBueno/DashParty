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
            Image("connectWithHubBackground")
                .resizable()
                .scaledToFill()
            
            HStack{
                Spacer()
                Button {
                    navigate = true
                } label: {
                    Image("buttonConnected")
                }
                Spacer()
            }
            
            NavigationLink(
                destination: NarrativePassingView(),
                isActive: $navigate,
                label: { EmptyView() }
            )
        }
        
    }
}
