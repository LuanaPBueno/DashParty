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
            @Bindable var manager = GameInformation.instance
            window.rootViewController = UIHostingController(rootView: RouterHubView(router: $manager.router))
            self.window = window
            window.makeKeyAndVisible()
        }
    }
}

  


