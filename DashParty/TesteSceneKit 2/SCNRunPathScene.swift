//
//  SCNRunPathScene.swift
//  TesteSceneKit
//
//  Created by Ricardo Almeida Venieris on 30/04/25.
//

import UIKit
import SceneKit

class SCNRunPathScene: SCNScene {

    let runner:RunnerNode

    let floor:SCNNode
    let grassfloor:SCNNode

    
    var vine: SCNNode

    let cameraNode:SCNNode

    let lightNode:SCNNode = {
        // create and add a light to the scene
        let lightNode = SCNNode()
        lightNode.light = SCNLight()
        lightNode.light!.type = .omni
        lightNode.light!.color = UIColor.blue
        lightNode.position = SCNVector3(x: 0, y: 30, z: 50)
        return lightNode

    }()

    let ambientLightNode:SCNNode = {
        // create and add an ambient light to the scene
        let ambientLightNode = SCNNode()
        ambientLightNode.light = SCNLight()
        ambientLightNode.light!.type = .ambient
        ambientLightNode.light!.color = UIColor.blue
        return ambientLightNode
    }()
    

    override init() {
        let modelScene = SCNScene(named: "art.scnassets/modelScene.scn")!

        let runner = RunnerNode()

        let floor = modelScene.rootNode.childNode(withName: "floor", recursively: true)!
        let grassfloor = modelScene.rootNode.childNode(withName: "grassfloor", recursively: true)!
        let vine = modelScene.rootNode.childNode(withName: "vine", recursively: true)!




        self.vine = vine

        self.runner = runner
        

        self.floor = floor
        self.grassfloor = grassfloor


        self.cameraNode = FollowCameraNode(target: runner)

        super.init()
        
        self.background.contents = modelScene.background.contents
        self.lightingEnvironment.contents = modelScene.lightingEnvironment.contents

        

        self.addAllNodes()


    }

    func addAllNodes() {
        self.rootNode.addChildNode(cameraNode)
        self.rootNode.addChildNode(lightNode)
        self.rootNode.addChildNode(ambientLightNode)
        self.rootNode.addChildNode(floor)
        self.rootNode.addChildNode(grassfloor)
        self.rootNode.addChildNode(runner)
        
        self.rootNode.addChildNode(TreesNodes(cameraNode: cameraNode))

        
        
//        for i in 1...50 {
//            self.rootNode.addChildNode(StoneNode(at: Float(i*20)))
//        }
        
    }


//    func addTroncos() {
//        
//        
//        // Logica para adicionar os troncos
//        
//        
//        let newTree = modelTrees.randomElement()!.copy() as! SCNNode
//        newTree.position.z = treePosStepZ * Float(trees.count) + Float.random(in: -1...1)
//        newTree.position.x = Float.random(in: trees.count.isEven ? treePosRightRangeX : treePosLeftRangeX)
//        trees.append(newTree)
//        self.rootNode.addChildNode(newTree)
//    }

    
    

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
