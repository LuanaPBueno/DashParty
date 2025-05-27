//
//  RunnerColor.swift
//  TesteSceneKit
//
//  Created by Ricardo Almeida Venieris on 03/05/25.
//

import Foundation

enum BitMasks: Int, CaseIterable {
    case runner = 1
    case ground = 2
    case obstacle = 4
    case hole = 8
    
    static var allMasks: Int { BitMasks.allCases.reduce(0, { $0 | $1.rawValue }) }
}
