//
//  Extensions.swift
//  TesteSceneKit
//
//  Created by Ricardo Almeida Venieris on 30/04/25.
//

import Foundation
import SceneKit

extension SCNVector3 {
    static func +(lhs: SCNVector3, rhs: SCNVector3) -> SCNVector3 {
        return SCNVector3(x: lhs.x + rhs.x, y: lhs.y + rhs.y, z: lhs.z + rhs.z)
    }
    static func += (lhs: inout SCNVector3, rhs: SCNVector3) {
        lhs = lhs + rhs
    }
    
    func distanceFrom(other: SCNVector3) -> Float {
        let dx = other.x - self.x
        let dy = other.y - self.y
        let dz = other.z - self.z
        return sqrtf(dx*dx + dy*dy + dz*dz)
    }
}


extension Int {
    var isEven: Bool {
        return self % 2 == 0
    }
}
