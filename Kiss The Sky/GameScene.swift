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
    
    var bgNode = SKSpriteNode()  // background property (as empty SKSpriteNode to be overridden in addCamera)
    
    let gameCamera = GameCamera()  // sets to custom GameCamera class (in "Custom Nodes" group)
    var panRecognizer = UIPanGestureRecognizer()  // recognizes pan gestures
    
    override func didMove(to view: SKView) {
        addBackground()
        addCamera()
        setUpGestureRecognizers()
    }
    
    func addBackground() {
        if let bgNode = childNode(withName: "Background Node") as? SKSpriteNode {
            self.bgNode = bgNode // sets bgNode as the child node named "Background Node" in GameScene.sks
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
    }
}


extension GameScene {
    
    @objc func pan(sender: UIPanGestureRecognizer) {
        guard let view = view else { return }
        let translation = sender.translation(in: view)
        gameCamera.position = CGPoint(x: gameCamera.position.x - translation.x, y: gameCamera.position.y + translation.y)
        sender.setTranslation(CGPoint.zero, in: view)
    }
    
}
