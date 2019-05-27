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
    
    let id: Int
    
    init(position: CGPoint, radius: CGFloat = screenWidth*0.001) {
        pointCount += 1
        self.id = pointCount
        super.init(texture: nil, color: .clear, size: CGSize(width: 0.0, height: 0.0))
        self.position = position
        self.isHidden = true
        self.physicsBody = SKPhysicsBody(circleOfRadius: radius)
        self.physicsBody?.allowsRotation = false  // removing rotation SHOULD improve performance?
        self.physicsBody?.categoryBitMask = moveableObjectsCollisionCategory
        self.physicsBody?.collisionBitMask = screenEdgesCollisionCategory
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}


func addPoint(at position: CGPoint, radius: CGFloat = screenWidth*0.001) -> Point {
    points.append( Point(position: position, radius: radius) )
    return points[points.count-1]
}








///////// JS ////////

//✓function Point(current_x, current_y, materiality="material") {
//X    this.saveTagClass = "point";  *omit from ios version
//✓    this.cx = current_x;  *handled by SKPhysicsBody
//✓    this.cy = current_y;  *handled by SKPhysicsBody
//✓    this.px = this.cx;  // previous x value  *handled by SKPhysicsBody
//✓    this.py = this.cy;  // previous y value  *handled by SKPhysicsBody
//✓    this.mass = 1;  // (as ratio of gravity)    *handled by SKSpriteNode
//✓    this.width = 0;
//✓    this.materiality = materiality;  *handle with collision masking
//✓    this.fixed = false;  *handle with SKPhysicsBody .isDynamic property
//✓    this.id = pointCount;
//✓    pointCount += 1;
//}

//✓function addPt(xPercent,yPercent,materiality="material") {
//✓    points.push( new Point( xValFromPct(xPercent), yValFromPct(yPercent), materiality ) );
//✓    return points[points.length-1];
//}
