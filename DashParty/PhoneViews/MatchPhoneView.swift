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
            EyesOnTheHub()
        }
        else{
            
        }
       
        
    }
}
