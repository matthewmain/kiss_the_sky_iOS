//
//  Span.swift
//  Kiss The Sky
//
//  Created by Matthew Main on 5/24/19.
//  Copyright © 2019 Matthew Main. All rights reserved.
//

import SpriteKit



////////////////// SPAN //////////////////


var spans: [Span] = []
var spanCount: Int = 0


class Span {
    
    let id: Int
    let p1: Point
    let p2: Point
    let length: CGFloat  // length
    let spring: SKPhysicsJointSpring
    
    init(connecting point1: Point, and point2: Point) {
        spanCount += 1
        self.id = spanCount
        self.p1 = point1
        self.p2 = point2
        self.length = distance(from: p1.position, to: p2.position)
        self.spring = SKPhysicsJointSpring.joint(withBodyA: point1.physicsBody!, bodyB: point2.physicsBody!, anchorA: point1.position, anchorB: point2.position)
        self.spring.frequency = 0.0  // stiffness: 0.0, default, is rigid; but values >0 increase from loose to stiff
        self.spring.damping = 0.0  // friction: 0.0 is default; increasing values add more friction, i.e. energy loss
    }
    
}



func addSpan(connecting point1: Point, and point2: Point) -> Span {
    spans.append( Span(connecting: point1, and: point2) )
    return spans[spans.count-1]
}


