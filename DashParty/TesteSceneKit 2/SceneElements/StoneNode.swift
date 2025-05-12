//
//  RockNode.swift
//  TesteSceneKit
//
//  Created by Ricardo Almeida Venieris on 03/05/25.
//

import Foundation
import SceneKit


class StoneNode: SCNNode {
    static let stoneHeight:CGFloat = 1.2
    static var stoneCount:Int = 0
    
    init(at zPosition:Float) {
        super.init()
        
        let image = UIImage(named: "stoneMoon")!
        let imageSize = image.size
        let imageScale = Self.stoneHeight / imageSize.height
        let planeSize = imageSize * imageScale

        // Create material
        let material = SCNMaterial ()
        material.lightingModel = .physicallyBased
        material.metalness.contents = 0.5
        material.roughness.contents = 0.2
        material.diffuse.contents = image
        // #colorLiteral(red: 0.9529411793, green: 0.6862745285, blue: 0.1333333403, alpha: 1)
        material.isDoubleSided = true

        // Create geometry
        let plane = SCNPlane(width: planeSize.width*2, height: planeSize.height)
        plane.firstMaterial = material

        // add geometry
        self.geometry = plane
        
        
        // add PhysicsSBody
        
//        let physicsGeometry = SCNCapsule(capRadius: planeSize.width/2.5, height: planeSize.height/1.2)
//        let physicsShape = SCNPhysicsShape(geometry: physicsGeometry, options: nil)
//        self.physicsBody = SCNPhysicsBody(type: .kinematic, shape: physicsShape)
//        self.physicsBody?.isAffectedByGravity = true
//        self.physicsBody?.categoryBitMask = BitMasks.obstacle.rawValue
//        self.physicsBody?.collisionBitMask = BitMasks.allMasks
//        self.physicsBody?.restitution = 2
//
//        self.physicsBody?.velocityFactor = SCNVector3(1, 0, 1)
//
//        // ❌ Impede rotações em qualquer eixo
//        self.physicsBody?.angularVelocityFactor = SCNVector3(0, 0, 0)

        position.y = Float(planeSize.height/2) - Float(planeSize.height)
        position.z = zPosition
        
        
        Self.stoneCount += 1

        runAction(
            SCNAction.move(by: SCNVector3(0, Float(planeSize.height), 0), duration: 0.5)
        )        
    }
    
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
