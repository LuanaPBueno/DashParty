//
//  SCNRunPathScene.swift
//  TesteSceneKit
//
//  Created by Ricardo Almeida Venieris on 30/04/25.
//

import UIKit
import SceneKit

class SCNRunPathScene: SCNScene {

    let runner:SCNNode
    let speedFactor:SpeedFactor
    var startPosition:Float
    var runnedDistance:Float {runner.presentation.position.z - startPosition}

    let floor:SCNNode
    let grassfloor:SCNNode
    let minZ: Float

    var trees:[SCNNode] = []
    var tronco:SCNNode
    var modelTrees:[SCNNode]
    let treePosRightRangeX: ClosedRange<Float>
    let treePosLeftRangeX: ClosedRange<Float>
    let treePosStepZ:Float = 4

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
    
    var ontrot:(_ distance: Float, _ speed: Float)->Void = {_, _ in }

    override init() {
        let modelScene = SCNScene(named: "art.scnassets/modelScene.scn")!

        let runner = modelScene.rootNode.childNode(withName: "runner", recursively: true)!
        

        let floor = modelScene.rootNode.childNode(withName: "floor", recursively: true)!
        let grassfloor = modelScene.rootNode.childNode(withName: "grassfloor", recursively: true)!


        let modelTrees = [
            modelScene.rootNode.childNode(withName: "tree0", recursively: true)!,
            modelScene.rootNode.childNode(withName: "tree1", recursively: true)!,
            modelScene.rootNode.childNode(withName: "tree2", recursively: true)!,
            modelScene.rootNode.childNode(withName: "tree3", recursively: true)!,
        ]

        self.tronco = modelScene.rootNode.childNode(withName: "tronco", recursively: true)!

        self.runner = runner
        self.startPosition = runner.worldPosition.z
        self.speedFactor = SpeedFactor(lastPosition: runner.worldPosition.z)

        self.floor = floor
        self.grassfloor = grassfloor
        self.minZ = floor.geometry?.boundingBox.min.z ?? 0

        self.modelTrees = modelTrees
        self.treePosRightRangeX =  modelTrees[0].position.x...modelTrees[2].position.x
        self.treePosLeftRangeX = modelTrees[3].position.x...modelTrees[1].position.x

        self.cameraNode = {
            // create and add a camera to the scene
            let cameraNode = SCNNode()
            cameraNode.camera = SCNCamera()
            // place the camera
            let startPosition = SCNVector3(x: 0, y: 4, z: -2)
            cameraNode.transform = SCNMatrix4MakeRotation(Float.pi, 0, 1, 0)
            cameraNode.position = startPosition

            // increase horizon distance
            cameraNode.camera?.zFar = 1000

            // follow the runner
            let delay = 0.2
            let folowRunner = SCNAction.run {node in
                var newPosition = startPosition
                newPosition.z += runner.presentation.worldPosition.z
                node.runAction(SCNAction.move(to: newPosition, duration: delay))
                //            print("newPosition", newPosition, self.ship.position)
            }
            let wait     = SCNAction.wait(duration: delay)
            let sequence = SCNAction.sequence([folowRunner, wait])
            let repeatSequence = SCNAction.repeatForever(sequence)
            cameraNode.runAction(repeatSequence)

            return cameraNode
        }()

        super.init()
        
        self.background.contents = modelScene.background.contents
        self.lightingEnvironment.contents = modelScene.lightingEnvironment.contents

        

        self.addAllNodes()
        trotLoopAnimatio()
        startTreeLoop()

    }

    func addAllNodes() {
        self.rootNode.addChildNode(cameraNode)
        self.rootNode.addChildNode(lightNode)
        self.rootNode.addChildNode(ambientLightNode)
        self.rootNode.addChildNode(floor)
        self.rootNode.addChildNode(grassfloor)

        for _ in 0..<100 {
            addNewTree()
        }
        self.rootNode.addChildNode(runner)
    }

    func addNewTree() {
        let newTree = modelTrees.randomElement()!.copy() as! SCNNode
        newTree.position.z = treePosStepZ * Float(trees.count) + Float.random(in: -1...1)
        newTree.position.x = Float.random(in: trees.count.isEven ? treePosRightRangeX : treePosLeftRangeX)
        trees.append(newTree)
        self.rootNode.addChildNode(newTree)
    }

    
    func addTroncos() {
        
        
        // Logica para adicionar os troncos
        
        
        let newTree = modelTrees.randomElement()!.copy() as! SCNNode
        newTree.position.z = treePosStepZ * Float(trees.count) + Float.random(in: -1...1)
        newTree.position.x = Float.random(in: trees.count.isEven ? treePosRightRangeX : treePosLeftRangeX)
        trees.append(newTree)
        self.rootNode.addChildNode(newTree)
    }

    
    
    func repositionFirstTree() {
        let lastZ = trees.last!.position.z
        let newZ = lastZ + treePosStepZ + Float.random(in: -1...1)
        trees.first?.position.z = newZ
        trees.moveSubranges(RangeSet(0..<1), to: trees.count)
    }

    func startTreeLoop() {
        Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: { _ in
            while self.trees.first!.position.z < self.cameraNode.position.z {
                self.repositionFirstTree()
            }
        })
    }


    func stepAnimation(runSpeed:Float = 0.5)->SCNAction {
        let duration:TimeInterval = min(0.6, TimeInterval(1.2/runSpeed))
        let rom:Float = min(0.3, runSpeed/10) // Range of motion
        print("rom", rom, "duration", duration, "runSpeed", runSpeed)
        let upAction = SCNAction.move(by: SCNVector3(0, rom, 0), duration: duration)
        upAction.timingMode = .easeOut

        let downAction = upAction.reversed()
        downAction.timingMode = .easeIn

        let flipAction = SCNAction.rotate(by: .pi, around: SCNVector3(0, 1, 0), duration: 0)

        let sequence = SCNAction.sequence([upAction, downAction, flipAction])
        return sequence
    }

    func trotLoopAnimatio() {

        let speed = self.speedFactor.current(in: runner.presentation.worldPosition.z)
        ontrot(runnedDistance, speed)

        guard speed > 0.12 else {
            runner.runAction(SCNAction.wait(duration: 0.1)) {
                self.trotLoopAnimatio()
            }
            return
        }

        runner.runAction(stepAnimation(runSpeed: speed)) {
            self.trotLoopAnimatio()
        }
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
