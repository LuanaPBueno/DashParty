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
    
    @Published var narrativeText: [[String : Bool]] = [
        ["Each generation, the Aru forest chooses its leader...": false],
        ["This leadership is not won with speeches or promises...": false],
        ["But with a race!": false],
        ["The trail challenges all who dare to compete. It is not just a path – it is alive. Full of traps, challenges, and mysteries.": false],
        ["Time for the great race! Who's ready to lose?": true],
        ["The race is not just about speed, Bongo. It's about strategy, intelligence, and—": true],
        ["—And not getting crushed by a giant bear?": true],
        ["Hey! Maybe the secret is… running over the competition!": true],
        ["I'd rather be eaten by a wolf!": true],
        ["If you're done arguing, can we start? The forest awaits us.": true],
        ["Four competitors, a single throne. The ground shakes. The leaves whisper. The race begins...": false],
        ["Now!": false]
    ]
    
    @Published var passToTutorialView: Bool = false
    
    @Published var actualPage: Int = 0
    
    @Published var startMatch: Bool = false
    
    @Published var changeScreen: Bool = false
    
    @Published var actualTutorialIndex: Int = 0
    
    private init() {}
}
