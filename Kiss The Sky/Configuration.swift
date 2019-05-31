//
//  Configuration.swift
//  Kiss The Sky
//
//  Created by Matthew Main on 5/20/19.
//  Copyright © 2019 Matthew Main. All rights reserved.
//

import CoreGraphics



///////// EXTENSIONS /////////


extension CGPoint {
    
    
    // redifines the CGPoint multiplication operator so that when multiplied by a CGFloat, it multiplies both its x and y values by the CGFloat and returns an updated CGPoint (used in GameScene.swift when `translation` is defined)
    static public func * (left: CGPoint, right: CGFloat) -> CGPoint {
        return CGPoint(x: left.x * right, y: left.y * right)
    }
    
    // redifines the CGPoint division operator so that when divided by a CGFloat, it divides both its x and y values by the CGFloat and returns an updated CGPoint
    static public func / (left: CGPoint, right: CGFloat) -> CGPoint {
        return CGPoint(x: left.x / right, y: left.y / right)
    }
    
    // redifines the CGPoint addition operator to automatically add both its x and y values and return the updated CGPoint (used in GameScene.Swift in the `pinch()` method definition)
    static public func + (left: CGPoint, right: CGPoint) -> CGPoint {
        return CGPoint(x: left.x + right.x, y: left.y + right.y)
    }
    
    // redifines the CGPoint subtraction operator to automatically subtract both its x and y values and return the updated CGPoint (used in GameScene.Swift in the `pinch()` method definition)
    static public func - (left: CGPoint, right: CGPoint) -> CGPoint {
        return CGPoint(x: left.x - right.x, y: left.y - right.y)
    }
    
    
}




///////// HELPER FUNCTIONS /////////


func distance(from point1: CGPoint, to point2: CGPoint ) -> CGFloat {
    return hypot(point1.x - point2.x, point1.y - point2.y)
}



