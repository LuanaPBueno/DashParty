//
//  MatchPhoneView.swift
//  DashParty
//
//  Created by Luana Bueno on 28/03/25.
//

import Foundation
import SwiftUI

struct matchPhoneView : View{
    @StateObject var hubManager = HUBPhoneManager.instance
    
    var body : some View{
        if !hubManager.endedGame {
            Image("matchPhoneViewBackground")
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
                            self.hubManager.objectWillChange.send()
                        }
                        
                } label: {
                    Image("newGameButton")
                }

               
            }
        }
        
    }
}
