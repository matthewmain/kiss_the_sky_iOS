//
//  Point.swift
//  Kiss The Sky
//
//  Created by Matthew Main on 5/21/19.
//  Copyright © 2019 Matthew Main. All rights reserved.
//

import SpriteKit



////////////////// POINT //////////////////


var points: [Point] = []
var pointCount: Int = 0

var pointsToAddAsChildren: [Point] = []   // for adding SKNodes as children from within GameScene


class Point: SKSpriteNode {
    let id: Int
    init(position: CGPoint, radius: CGFloat = screenHeight*0.001) {
        pointCount += 1
        self.id = pointCount
        super.init(texture: nil, color: .clear, size: CGSize(width: 0.0, height: 0.0))
        self.name = "Custom Verlet Point"
        self.position = position
        self.isHidden = true
        self.physicsBody = SKPhysicsBody(circleOfRadius: radius)
        self.physicsBody?.allowsRotation = false  // removing rotation SHOULD improve performance?
        self.physicsBody?.categoryBitMask = solidMoveableObjectsCollisionCategory
        self.physicsBody?.collisionBitMask = screenEdgesCollisionCategory
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}



func addPoint(at position: CGPoint, radius: CGFloat = screenHeight*0.001) -> Point {
    points.append( Point(position: position, radius: radius) )
    pointsToAddAsChildren.append(points[points.count-1])  // for adding SKNodes as children from within GameScene
    return points[points.count-1]
}


func removePoint(byId id: Int) {
    if let index = points.firstIndex(where: { $0.id == id }) {
        points[index].removeFromParent()  // removes from GameScene
        points.remove(at: index)  // removes from points collection
    }
}



