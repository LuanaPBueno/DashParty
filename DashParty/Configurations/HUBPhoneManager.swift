//
//  HUBPhoneManager.swift
//  DashParty
//
//  Created by Luana Bueno on 24/03/25.
//

import Foundation
import SwiftUI

class HUBPhoneManager: ObservableObject {
    static let instance = HUBPhoneManager()
    
    @Published var changeScreem: Bool = false
    
    private init() {} // Impede a criação de novas instâncias
}
