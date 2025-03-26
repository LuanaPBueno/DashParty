//
//  TutorialHubView .swift
//  DashParty
//
//  Created by Luana Bueno on 26/03/25.
//

import Foundation
import SwiftUI

struct TutorialHubView: View {
    @ObservedObject var hubManager = HUBPhoneManager.instance
    
    var currentTutorialImage: [String] = ["tutorialBackgroundHub1", "tutorialBackgroundHub2", "tutorialBackgroundHub3"]
    
    var body: some View {
        Image(currentTutorialImage[safe: hubManager.actualTutorialIndex] ?? "fallbackImage")
            .resizable()
            .scaledToFill()
            .edgesIgnoringSafeArea(.all)
    }
}

extension Array {
    subscript(safe index: Int) -> Element? {
        return indices.contains(index) ? self[index] : nil
    }
}
