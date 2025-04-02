//
//  AppDelegate.swift
//  DashParty
//
//  Created by Luana Bueno on 24/03/25.
//


import Foundation
import SwiftUI
import NearbyInteraction

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]? = nil) -> Bool {
        // Check Nearby Interaction device support
        var isSupported: Bool
        if #available(iOS 16.0, *) {
            isSupported = NISession.deviceCapabilities.supportsPreciseDistanceMeasurement
        } else {
            isSupported = NISession.isSupported
        }
        
        if !isSupported {
            print("Device doesn't support Nearby Interaction")
            // You might want to show an alert or switch to a different view here
            // For SwiftUI, you could set up a state variable to trigger an alert
        }
        
        return true
    }
    
    func application(_ application: UIApplication,
                     configurationForConnecting connectingSceneSession: UISceneSession,
                     options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        let sceneConfiguration = UISceneConfiguration(name: nil, sessionRole: connectingSceneSession.role)
        sceneConfiguration.delegateClass = SceneDelegate.self
        return sceneConfiguration
    }
}
