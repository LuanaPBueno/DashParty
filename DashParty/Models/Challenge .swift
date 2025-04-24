//
//  Challenge .swift
//  DashParty
//
//  Created by Luana Bueno on 11/03/25.
//

import Foundation
import UIKit

enum Challenge: Codable {
    
    case running
    case jumping
    case openingDoor
    case balancing
    case stopped
    
    var name: String {
        switch self {
        case .running:
            "RUN"
        case .jumping:
            "JUMP"
        case .openingDoor:
            "PUSH"
        case .balancing:
            "BALANCE"
        case .stopped:
            "Stopped"
        }
        
    }
    
    var animation: UIImage {
        switch self {
        case .running:
            UIImage(named: "orangePerson")!
        case .jumping:
            UIImage(named: "bluePerson")!
        case .openingDoor:
            UIImage(named: "greenPerson")!
        case .balancing:
            UIImage(named: "orangePerson")!
        case .stopped:
            UIImage(named: "orangePerson")!

        }
    }
}
