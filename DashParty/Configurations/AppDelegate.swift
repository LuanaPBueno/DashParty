//
//  AppDelegate.swift
//  DashParty
//
//  Created by Luana Bueno on 24/03/25.
//


import Foundation
import SwiftUI

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]? = nil) -> Bool {
        return true
    }
    
    func applicationDidEnterBackground(_ application: UIApplication) {
        MPCSessionManager.shared.appDidEnterBackground()
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        MPCSessionManager.shared.appWillEnterForeground()
    }
    
    func application(_ application: UIApplication,
                     configurationForConnecting connectingSceneSession: UISceneSession,
                     options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        let sceneConfiguration = UISceneConfiguration(name: nil, sessionRole: connectingSceneSession.role)
        sceneConfiguration.delegateClass = SceneDelegate.self
        return sceneConfiguration
    }
}
