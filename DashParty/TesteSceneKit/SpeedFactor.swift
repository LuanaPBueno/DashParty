//
//  SpeedFactor.swift
//  TesteSceneKit
//
//  Created by Ricardo Almeida Venieris on 30/04/25.
//

import Foundation
import SceneKit

class SpeedFactor {
    var lastTime: Date
    var lastPosition: Float = 0
    var lastV3Position: SCNVector3 = .init(x: 0, y: 0, z: 0)
    var currentSpeed:Float = 0
    
    func current(in newPosition:Float)->Float{
        let deltaTime:TimeInterval = Date().timeIntervalSince(lastTime)
        let deltaPosition:Float = newPosition - lastPosition
        lastTime = Date()
        lastPosition = newPosition
        currentSpeed = deltaPosition / Float(deltaTime)
        return currentSpeed
        
    }
    
    func current(in newPosition:SCNVector3)->Float{
        let deltaTime:TimeInterval = Date().timeIntervalSince(lastTime)
        let deltaPosition = newPosition.distanceFrom(other: lastV3Position)
        lastTime = Date()
        lastV3Position = newPosition
        currentSpeed = deltaPosition / Float(deltaTime)
        return currentSpeed
        
    }
    
    init(lastTime: Date = Date(), lastPosition: Float = 0) {
        self.lastTime = lastTime
        self.lastPosition = lastPosition
    }
    
    
}
