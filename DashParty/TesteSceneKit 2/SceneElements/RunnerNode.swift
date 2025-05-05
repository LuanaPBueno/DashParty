//
//  RunnerNode.swift
//  TesteSceneKit
//
//  Created by Ricardo Almeida Venieris on 03/05/25.
//

import Foundation
import SceneKit

enum RunnerColor: String, CaseIterable {
    case red, blue, green, yellow
}

enum RunnerState: String, CaseIterable {
    case running, jumping, openingDoor, idle
}


class RunnerNode:SCNNode {
    
    static let runnerHeight:CGFloat = 1.5
    static let totalImages = 5
    static let stepSize:CGFloat = 0.7

    let stepSliceFactor:Float

    private let runnerColor:RunnerColor
    private let animationImages:[UIImage]
    var runnerState:RunnerState = .running
    
    
//    var startPosition:Float = 0

    let floorHeight:Float
    let speedFactorZ:SpeedFactor
    let speedFactorY:SpeedFactor
    var runnedDistance:Float {self.presentation.position.z} // - startPosition}
    
    var speed:Float {self.speedFactorZ.current(in: self.presentation.worldPosition.z)}
    
    var vSpeed:Float {self.speedFactorY.current(in: self.presentation.worldPosition.y)}

    var isJumping:Bool {
        abs(self.speedFactorY.current(in: self.presentation.worldPosition.y)) > 0.05
    }

    var ontrot:(_ distance: Float)->Void = {_ in }
    
    
    init(color:RunnerColor = .red) {
        var images = (1...RunnerNode.totalImages).map{UIImage(named:"\(color)Bunny\($0).png")!}
        let flipped = images.compactMap{ $0.flipped }
        images.append(contentsOf: flipped)
        
        self.runnerColor = color
        self.animationImages = images
        self.stepSliceFactor = Float(Self.totalImages * 2) * Float(Self.stepSize)
        self.speedFactorZ = SpeedFactor(lastPosition: 0)
        self.speedFactorY = SpeedFactor(lastPosition: 0)

        let imageSize = animationImages[0].size
        let imageScale = Self.runnerHeight / imageSize.height
        let planeSize = imageSize * imageScale
        
        
        self.floorHeight = Float(planeSize.height/2)
        
        super.init()
        
        // Create material
        let material = SCNMaterial ()
        material.lightingModel = .physicallyBased
        material.metalness.contents = 0.5
        material.roughness.contents = 0.2
        material.diffuse.contents = animationImages[0]
        // #colorLiteral(red: 0.9529411793, green: 0.6862745285, blue: 0.1333333403, alpha: 1)
        material.isDoubleSided = true

        // Create geometry
        let plane = SCNPlane(width: planeSize.width, height: planeSize.height)
        plane.firstMaterial = material

        // add geometry
        self.geometry = plane
        
        
        // add PhysicsSBody
        
        let physicsGeometry = SCNBox(width: plane.width/4, height: plane.height/1.7, length: 0.1, chamferRadius: 100)
        
        let physicsShape = SCNPhysicsShape(geometry: physicsGeometry, options: nil)
        self.physicsBody = SCNPhysicsBody(type: .dynamic, shape: physicsShape)
        self.physicsBody?.isAffectedByGravity = true
        self.physicsBody?.categoryBitMask = 1
        self.physicsBody?.contactTestBitMask = BitMasks.allMasks
        self.physicsBody?.collisionBitMask = BitMasks.allMasks
        
        // ❌ Impede movimento no eixo X (só permite no eixo Y e Z)
        self.physicsBody?.velocityFactor = SCNVector3(0, 1, 1)

        // ❌ Impede rotações em qualquer eixo
        self.physicsBody?.angularVelocityFactor = SCNVector3(0, 0, 0)

        
        position.y = floorHeight
        startAnimation()
    }
    
    
    
    
    
    
    func startAnimation() {
        Timer.scheduledTimer(withTimeInterval: 1/10, repeats: true) { _ in
            self.ontrot(self.runnedDistance)
//            print(self.speed, self.vSpeed, self.isJumping, self.runnerState)
            
            self.setFrame()
        }
    }
    
    func checkRunnerState() {
        if isJumping {
            runnerState = .jumping
            return
        }
        
        if speed > 0.01 {
            runnerState = .running
            return
        }
        
        runnerState = .idle

    }
    
    func setFrame() {
        self.checkRunnerState()
        switch runnerState {
            
        case .running:
            let vFrameIndex = Int(self.presentation.worldPosition.z * stepSliceFactor) % self.animationImages.count
            self.geometry?.firstMaterial?.diffuse.contents = animationImages[vFrameIndex]
            break
        case .jumping:
            self.geometry?.firstMaterial?.diffuse.contents = animationImages[3]
        case .openingDoor:
            break
        case .idle:
            self.geometry?.firstMaterial?.diffuse.contents = animationImages[0]
        }
    }
    

    func run() {
        runnerState = .running
        self.physicsBody?.applyForce(SCNVector3(x: 0, y: 0, z: 1), at: SCNVector3(x: 0, y: 0, z: 0), asImpulse: true)
    }
    
    func jump() {
        
        guard !isJumping else { return }
        runnerState = .jumping
        self.physicsBody?.applyForce(SCNVector3(x: 0, y: 5, z: 2), at: SCNVector3(x: 0, y: 0, z: 0), asImpulse: true)

    }

    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
