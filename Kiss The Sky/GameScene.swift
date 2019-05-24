//
//  GameScene.swift
//  Kiss The Sky
//
//  Created by Matthew Main on 5/18/19.
//  Copyright © 2019 Matthew Main. All rights reserved.
//

import SpriteKit
import GameplayKit

let deviceBounds = UIScreen.main.fixedCoordinateSpace.bounds  // current device screen size (call as .height or .width)




let boxSize = deviceBounds.width*0.1
let boxCenter = CGPoint(x: deviceBounds.width*0.5, y: deviceBounds.height*0.75)

var point1 = Point(position: CGPoint(x: boxCenter.x-boxSize/2, y: boxCenter.y+boxSize/2))
var point2 = Point(position: CGPoint(x: boxCenter.x+boxSize/2, y: boxCenter.y+boxSize/2))
var point3 = Point(position: CGPoint(x: boxCenter.x+boxSize/2, y: boxCenter.y-boxSize/2))
var point4 = Point(position: CGPoint(x: boxCenter.x-boxSize/2, y: boxCenter.y-boxSize/2))

var span1 = Span(connecting: point1, and: point2)
var span2 = Span(connecting: point2, and: point3)
var span3 = Span(connecting: point3, and: point4)
var span4 = Span(connecting: point4, and: point1)
var span5 = Span(connecting: point1, and: point3)



var boxShapes: [SKShapeNode] = []


class GameScene: SKScene {
    
    var entities = [GKEntity]()
    var graphs = [String : GKGraph]()
    
    var bgNode = SKSpriteNode()  // background node
    var dfvNode = SKSpriteNode()  // device frame visualizer node
    let deviceBounds = UIScreen.main.fixedCoordinateSpace.bounds  // current device screen size (call as .height or .width)
    
    let gameCamera = GameCamera()  // sets to custom GameCamera class (in "Custom Nodes" group)
    let minZoomRatio: CGFloat = 0.5  // minimum zoom ratio of device screen size
    let maxZoomRatio: CGFloat = 1  // maximum zoom ratio of device screen size
    var panRecognizer = UIPanGestureRecognizer()  // recognizes pan gestures
    var pinchRecognizer = UIPinchGestureRecognizer()  // recognizes pinch gestures
    
    
    override func didMove(to view: SKView) {
        addBackground()
        addCamera()
        setUpGestureRecognizers()
        
        
        
    
        //Spring Joint Box (points as SKSpriteNodes, spans as SKPhysicsJointSprings)
        
        physicsBody = SKPhysicsBody(edgeLoopFrom: frame)
        physicsBody?.categoryBitMask = screenEdgesCollisionCategory
        physicsBody?.collisionBitMask = moveableObjectsCollisionCategory

        addChild(point1)
        addChild(point2)
        addChild(point3)
        addChild(point4)
        
        physicsWorld.add(span1.spring)
        physicsWorld.add(span2.spring)
        physicsWorld.add(span3.spring)
        physicsWorld.add(span4.spring)
        physicsWorld.add(span5.spring)

        

        
        
    }
    
    
    
    
    override func didSimulatePhysics() {
    
        let boxPath = CGMutablePath()
        boxPath.move(to: point1.position)
        boxPath.addLine(to: point2.position)
        boxPath.addLine(to: point3.position)
        boxPath.addLine(to: point4.position)
        boxPath.closeSubpath()
        
        let boxShape = SKShapeNode()
        boxShape.path = boxPath
        boxShape.fillColor = .red
        boxShape.lineWidth = 0.5
        boxShape.strokeColor = .black
        boxShape.glowWidth = 0.2
        boxShape.zPosition = 1
        
        removeChildren(in: boxShapes)  // clears last frame's box shape children from GameScene
        boxShapes = []  // clears last frame's box shapes from collection array
        
        boxShapes.append(boxShape)  // adds new box shape to collection array
        addChild(boxShape)  // adds new box shape as child of GameScene
        
        
    }
    
    
    
    
    func addBackground() {
        if let dfvNode = childNode(withName: "Device Frame Visualizer Node") as? SKSpriteNode {
            self.dfvNode = dfvNode
            self.dfvNode.alpha = viewDeviceFramesVisualizer ? 1 : 0
        }
        if let bgNode = childNode(withName: "Background Node") as? SKSpriteNode {
            self.bgNode = bgNode
        }
    }
    
    
    func addCamera() {
        guard let view = view else { return }
        addChild(gameCamera)
        gameCamera.position = CGPoint(x: view.bounds.size.width/2, y: view.bounds.size.height/2)
        camera = gameCamera
        gameCamera.setConstraints(with: self, and: deviceBounds, to: nil)
    }
    
    
    func setUpGestureRecognizers() {
        guard let view = view else { return }
        panRecognizer = UIPanGestureRecognizer(target: self, action: #selector(pan))
        view.addGestureRecognizer(panRecognizer)
        pinchRecognizer = UIPinchGestureRecognizer(target: self, action: #selector(pinch))
        view.addGestureRecognizer(pinchRecognizer)
    }
    
}


extension GameScene {
    
    
    @objc func pan(sender: UIPanGestureRecognizer) {
        guard let view = view else { return }
        let translation = sender.translation(in: view) * gameCamera.yScale  // ensures pan rate matches scale ( multiplying CGPoint & CGFloat possible because handled in Configuration.swift CGPoint extension)
        let maxCameraX = deviceBounds.height - deviceBounds.height * gameCamera.yScale / 2
        let maxCameraY = deviceBounds.width - deviceBounds.width * gameCamera.xScale / 2
        if gameCamera.position.x <= maxCameraX && gameCamera.position.y <= maxCameraY {
            gameCamera.position = CGPoint(x: gameCamera.position.x - translation.x, y: gameCamera.position.y + translation.y)
        } else if gameCamera.position.x > maxCameraX {
            gameCamera.position.x = maxCameraX
        } else if gameCamera.position.y > maxCameraY {
            gameCamera.position.y = maxCameraY
        }
        sender.setTranslation(CGPoint.zero, in: view)  // resets translation to 0
    }
    
    
    @objc func pinch(sender: UIPinchGestureRecognizer) {
        guard let view = view else { return }
        if sender.numberOfTouches == 2 {  // detects a potential pinch gesture...
            let locationInView = sender.location(in: view)  // stores position of pinch gesture in the view
            let location = convertPoint(fromView: locationInView)  // converts location to point before scaling
            if sender.state == .changed {  // ...confirms pinch gesture on change while two fingers are touching
                let convertedScale = 1/sender.scale  // stores scale as fraction
                let newScale = gameCamera.yScale * convertedScale  // converts scale to fraction of camera scale (can use y or x, same fixed fraction)
                if newScale <= maxZoomRatio && newScale >= minZoomRatio {  // checks if scale is within zoom bounds
                    gameCamera.setScale(newScale) // assigns new scale to game camera
                } else if newScale > maxZoomRatio {
                    gameCamera.setScale(maxZoomRatio)  // if zoom out exceeds max, sets back to max
                } else if newScale < minZoomRatio {
                    gameCamera.setScale(minZoomRatio)  // if zoom in goes below min, sets back to min
                }
                let locationAfterScale = convertPoint(fromView: locationInView)  // converts location to point after scaling
                let locationDelta = location - locationAfterScale  // stores offset of position before and after scaling process (possible to subtract two CGPoints here because handled in Configuration.swift CGPoint extension)
                let newPosition = gameCamera.position + locationDelta  // stores new position calculated based on pinch gesture location and scaling (possible to add two CGPoints here because handled in Configuration.swift CGPoint extension)
                gameCamera.position = newPosition  // keeps camera centered on pinch gesture
                sender.scale = 1.0  // resets the sender's scale
                gameCamera.setConstraints(with: self, and: bgNode.frame, to: nil)  // updates camera pan & zoom constraints to match scaling of scene
            }
        }
    }
    
    
}



