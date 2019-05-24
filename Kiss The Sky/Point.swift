//
//  Point.swift
//  Kiss The Sky
//
//  Created by Matthew Main on 5/21/19.
//  Copyright © 2019 Matthew Main. All rights reserved.
//

import SpriteKit


var points: [Point] = []
var pointCount: Int = 0


class Point: SKSpriteNode {
    
    init(position: CGPoint) {
        super.init(texture: nil, color: .clear, size: CGSize(width: 0.0, height: 0.0))
        self.position = position
        physicsBody = SKPhysicsBody(circleOfRadius: deviceBounds.width*0.001)
        physicsBody?.allowsRotation = false  // removing rotation SHOULD improve performance?
        physicsBody?.categoryBitMask = moveableObjectsCollisionCategory
        physicsBody?.collisionBitMask = screenEdgesCollisionCategory
        zPosition = 1
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
