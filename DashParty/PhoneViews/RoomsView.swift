//
//  Untitled.swift
//  DashParty
//
//  Created by Maria Eduarda Mariano on 09/04/25.
//

import Foundation
import SwiftUI

struct RoomsView: View{
    
    var multipeerSession : MPCSession!
    @State var navigate : Bool = false
    @State var changed: Bool = HUBPhoneManager.instance.changeScreen
    @State private var isActive = false
    
    var body: some View{
        ZStack{
            Image("purpleBackground")
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()
        }
    }
}

#Preview {
    RoomsView()
}
