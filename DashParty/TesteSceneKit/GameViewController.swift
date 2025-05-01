//
//  GameViewController.swift
//  TesteSceneKit
//
//  Created by Ricardo Almeida Venieris on 28/04/25.
//

import UIKit
import QuartzCore
import SceneKit

class GameViewController: UIViewController {

    // retrieve the SCNView
    lazy var scnView1 = SCNRunPathView(frame: CGRect(x: 0, y: 0,
                                                             width: UIScreen.main.bounds.width/2 - 5,
                                                             height: UIScreen.main.bounds.height))

    
    lazy var scnView2 = SCNRunPathView(frame: CGRect(x: UIScreen.main.bounds.midX + 10, y: 0,
                                                      width: UIScreen.main.bounds.width/2 - 5,
                                                      height: UIScreen.main.bounds.height))
    
    

    override func viewDidLoad() {
//        print("floor.frame", floor.geometry?.boundingBox.min)
        super.viewDidLoad()
        self.view.addSubview(scnView1)
        self.view.addSubview(scnView2)
    }
    
    
    // Aqui troca o touches por sua solução
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        for touch in touches {
            let location = touch.location(in: view)
            let isLeft = location.x < view.bounds.midX
            
            if isLeft {
                scnView1.runPathScene.runner.physicsBody?.applyForce(SCNVector3(x: 0, y: 0, z: 1), at: SCNVector3(x: 0, y: 0, z: 0), asImpulse: true)
            } else {
                scnView2.runPathScene.runner.physicsBody?.applyForce(SCNVector3(x: 0, y: 0, z: 1), at: SCNVector3(x: 0, y: 0, z: 0), asImpulse: true)
            }
            
            
        }
        
        
        
    }
    
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let location = touch.location(in: view)
            let isLeft = location.x < view.bounds.midX
    
            // parou de mexer
            if isLeft {
                scnView1.runPathScene.runner.physicsBody?.clearAllForces()
            } else {
                scnView2.runPathScene.runner.physicsBody?.clearAllForces()
            }
            
            
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
            // return to idle
        
    }

    
    

    
    override var prefersStatusBarHidden: Bool { return true }
    
}



extension GameViewController: SCNPhysicsContactDelegate {
    
}



