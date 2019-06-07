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

var spanSpringsToAddToPhysicsWorld: [SKPhysicsJointSpring] = []   // for adding joints to physicsWorld from within GameScene


class Span {
    let id: Int
    let p1: Point
    let p2: Point
    let length: CGFloat
    let spring: SKPhysicsJointSpring
    init(connecting point1: Point, and point2: Point) {
        spanCount += 1
        self.id = spanCount
        self.p1 = point1
        self.p2 = point2
        self.length = distance(from: p1.position, to: p2.position)
        self.spring = SKPhysicsJointSpring.joint(withBodyA: point1.physicsBody!, bodyB: point2.physicsBody!, anchorA: point1.position, anchorB: point2.position)
        spring.frequency = 0.0  // stiffness: 0.0, default, is rigid; but values >0 increase from loose to stiff
        spring.damping = 0.0  // friction: 0.0 is default; increasing values add more friction, i.e. energy loss
    }
}



func addSpan(connecting point1: Point, and point2: Point) -> Span {
    spans.append( Span(connecting: point1, and: point2) )
    spanSpringsToAddToPhysicsWorld.append(spans[spans.count-1].spring)  // for adding SKPhysicsJointSpring to the physics world in GameScene
    return spans[spans.count-1]
}


func spanMidPoint(span: Span) -> CGPoint {
    let midX: CGFloat = ( span.p1.position.x + span.p2.position.x ) / 2
    let midY: CGFloat = ( span.p1.position.y + span.p2.position.y ) / 2
    return CGPoint(x: midX, y: midY)
}


func removeSpan(byId id: Int) {
    if let index = spans.firstIndex(where: { $0.id == id }) {
        currentPhysicsWorld?.remove(spans[index].spring)
        spans.remove(at: index)
    }
}







