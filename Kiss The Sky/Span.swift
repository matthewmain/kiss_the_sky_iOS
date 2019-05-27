//
//  Span.swift
//  Kiss The Sky
//
//  Created by Matthew Main on 5/24/19.
//  Copyright © 2019 Matthew Main. All rights reserved.
//


import SpriteKit


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








///////// JS ////////

//✓function Span(point_1, point_2, visibility="visible") {
//X    this.saveTagClass = "span";
//✓    this.p1 = point_1;
//✓    this.p2 = point_2;
//✓    this.l = distance(this.p1,this.p2); // length
//✓    this.strength = 1;  *handled by .frequency
//✓    this.visibility = visibility;  *handle with view.showsPhysics = true
//✓    this.id = spanCount;
//✓    spanCount += 1;
//}
//

//function addSp(p1,p2,visibility="visible") {
//    spans.push( new Span( getPt(p1), getPt(p2), visibility ) );
//    return spans[spans.length-1];
//}
