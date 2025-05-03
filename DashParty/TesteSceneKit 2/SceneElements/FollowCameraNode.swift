//
//  FollowCameraNode.swift
//  TesteSceneKit
//
//  Created by Ricardo Almeida Venieris on 03/05/25.
//

import Foundation
import SceneKit


class FollowCameraNode: SCNNode {
    
    let target: SCNNode
    
    init(target: SCNNode, elevation: Float = 1.5, distance: Float = 2.5) {
        self.target = target
        super.init()
        
        
        // create and add a camera to the scene
        self.camera = SCNCamera()
        // place the camera
        let startPosition = SCNVector3(x: 0,
                                       y: target.position.y * elevation,
                                       z: -distance)
        self.transform = SCNMatrix4MakeRotation(Float.pi, 0, 1, 0)
        self.position = startPosition
        
        print("self.eulerAngles.x", self.eulerAngles.x)
//        self.eulerAngles.x -= .pi / 8

        // increase horizon distance
        self.camera?.zFar = 1000

        // follow the runner
        let delay = 0.1
        let folowRunner = SCNAction.run {node in
            var newPosition = startPosition
            newPosition.z += target.presentation.worldPosition.z
            node.runAction(SCNAction.move(to: newPosition, duration: delay))
            //            print("newPosition", newPosition, self.ship.position)
        }
        let wait     = SCNAction.wait(duration: delay)
        let sequence = SCNAction.sequence([folowRunner, wait])
        let repeatSequence = SCNAction.repeatForever(sequence)
        self.runAction(repeatSequence)

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
