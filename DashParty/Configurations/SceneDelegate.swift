//
//  SceneDelega5e.swift
//  DashParty
//
//  Created by Luana Bueno on 24/03/25.
//

import Foundation
import SwiftUI

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions){
        guard let windowSecene = scene as? UIWindowScene else {return}
        
        if session.role == .windowExternalDisplayNonInteractive{
            let window = UIWindow(windowScene: windowSecene)
            window.rootViewController = UIHostingController(rootView: FirstHubView())
            self.window = window
            window.makeKeyAndVisible()
        }
    }
}


