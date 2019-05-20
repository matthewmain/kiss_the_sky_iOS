//
//  GameScene.swift
//  Kiss The Sky
//
//  Created by Matthew Main on 5/18/19.
//  Copyright © 2019 Matthew Main. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    
    var entities = [GKEntity]()
    var graphs = [String : GKGraph]()
    
    var bgNode = SKSpriteNode()  // background property (as empty SKSpriteNode to be overridden in addCamera())
    let gameCamera = GameCamera()  // sets to custom GameCamera class (in "Custom Nodes" group)
    var panRecognizer = UIPanGestureRecognizer()  // recognizes pan gestures
    var pinchRecognizer = UIPinchGestureRecognizer()  // recognizes pinch gestures
    var maxScale: CGFloat = 0  // max scale for zoom (value to be overridden in pinch())
    
    override func didMove(to view: SKView) {
        addBackground()
        addCamera()
        setUpGestureRecognizers()
    }
    
    func addBackground() {
        if let bgNode = childNode(withName: "Background Node") as? SKSpriteNode {
            self.bgNode = bgNode // sets bgNode as the child node named "Background Node" in GameScene.sks
            maxScale = frame.size.height > frame.size.width ? bgNode.size.height/frame.size.height : bgNode.size.width/frame.size.width  // sets max zoom out to size of scene depending on whether the scene's height or width is larger
        }
    }
    
    func addCamera() {
        guard let view = view else { return }
        addChild(gameCamera)
        gameCamera.position = CGPoint(x: view.bounds.size.width/2, y: view.bounds.size.height/2)
        camera = gameCamera
        gameCamera.setConstraints(with: self, and: bgNode.frame, to: nil)
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
        gameCamera.position = CGPoint(x: gameCamera.position.x - translation.x, y: gameCamera.position.y + translation.y)
        sender.setTranslation(CGPoint.zero, in: view)
    }
    
    @objc func pinch(sender: UIPinchGestureRecognizer) {
        guard let view = view else { return }
        if sender.numberOfTouches == 2 {  // detects a potential pinch gesture...
            let locationInView = sender.location(in: view)  // stors position of pinch gesture in the view
            let location = convertPoint(fromView: locationInView)  // converts location to point before scaling
            if sender.state == .changed {  // ...confirms pinch gesture on change while two fingers are touching
                let convertedScale = 1/sender.scale  // stores scale as fraction
                let newScale = gameCamera.yScale*convertedScale  // converts scale to fraction of camera scale (can use y or x)
                if newScale < maxScale && newScale > 0.5 {  // restricts zoom out to scene size and zoom in to 2x
                    gameCamera.setScale(newScale) // assigns new scale to game camera
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
