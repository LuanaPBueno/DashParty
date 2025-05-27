//
//  TreesNodes.swift
//  TesteSceneKit
//
//  Created by Ricardo Almeida Venieris on 03/05/25.
//

import Foundation
import SceneKit

class TreesNodes: SCNNode {
    
    var trees:[SCNNode] = []
    var modelTrees:[SCNNode]
    let treePosRightRangeX: ClosedRange<Float>
    let treePosLeftRangeX: ClosedRange<Float>
    let treePosStepZ:Float = 0.3
    let treeZDensity:Float = 1


    init(count:Int = 300, cameraNode:SCNNode) {
        let modelScene = SCNScene(named: "art.scnassets/modelScene.scn")!
        let modelTrees = [
            modelScene.rootNode.childNode(withName: "treeMoon0", recursively: true)!,
            modelScene.rootNode.childNode(withName: "treeMoon1", recursively: true)!,
            modelScene.rootNode.childNode(withName: "treeMoon2", recursively: true)!,
            modelScene.rootNode.childNode(withName: "treeMoon3", recursively: true)!,
        ]
        
        let leftTrees = modelTrees.filter { $0.position.x < 0 }
        let minLeft = leftTrees.map{$0.position.x}.min() ?? 0
        let maxLeft = leftTrees.map{$0.position.x}.max() ?? 0

        let rightTrees = modelTrees.filter { $0.position.x >= 0 }
        let minRight = rightTrees.map{$0.position.x}.min() ?? 0
        let maxRight = rightTrees.map{$0.position.x}.max() ?? 0

        self.modelTrees = modelTrees
        self.treePosRightRangeX =  minLeft...maxLeft
        self.treePosLeftRangeX = minRight...maxRight
        
        
        super.init()
        
        addTrees(count: count)
        startTreeLoop(using: cameraNode)
        
    }
    
    func addTrees(count:Int) {
        for _ in 0..<count {
            addNewTree()
        }
    }
    
    func newZPosition() -> Float {
        (trees.last?.position.z ?? 0) +
        treePosStepZ +
        Float.random(in: -treeZDensity...treeZDensity)

    }
    
    func addNewTree() {
        let newTree = modelTrees.randomElement()!.copy() as! SCNNode
        newTree.position.z = newZPosition()
        newTree.position.x = Float.random(in: trees.count.isEven ? treePosRightRangeX : treePosLeftRangeX)
        trees.append(newTree)
        addChildNode(newTree)
    }
    
    func repositionFirstTree() {
        trees.first?.position.z = newZPosition()
        trees.moveSubranges(RangeSet(0..<1), to: trees.count)
    }

    func startTreeLoop(using cameraNode:SCNNode) {
        Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true, block: { _ in
            while self.trees.first!.position.z < cameraNode.position.z {
                self.repositionFirstTree()
            }
        })
    }


    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
