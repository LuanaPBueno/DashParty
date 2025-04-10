//
//  MatchPhoneView.swift
//  DashParty
//
//  Created by Luana Bueno on 28/03/25.
//

import Foundation
import SwiftUI

struct matchPhoneView : View{
    @State var hubManager = HUBPhoneManager.instance
    
    var body : some View{
        if !hubManager.endedGame {
            Text("oioioioioioioi")
        }
        else{
            ZStack{
                Image("pinkBackground")
                    .resizable()
                    .scaledToFill()
                    .ignoresSafeArea(.all)
                
                Button {
                    HUBPhoneManager.instance.newGame = true
                    DispatchQueue.main.async {
//                            self.hubManager.objectWillChange.send()
                        }
                        
                } label: {
                    Image("newGameButton")
                }

               
            }
        }
        
    }
}
