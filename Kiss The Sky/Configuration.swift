//
//  Configuration.swift
//  Kiss The Sky
//
//  Created by Matthew Main on 5/20/19.
//  Copyright © 2019 Matthew Main. All rights reserved.
//

import CoreGraphics

extension CGPoint {
    
    
    // redifines the CGPoint multiplication operator so that when multiplied by a CGFloat, it multiplies both its x and y values by the CGFloat and returns an updated CGPoint (used in GameScene.swift when `translation` is defined)
    static public func * (left: CGPoint, right: CGFloat) -> CGPoint {
        return CGPoint(x: left.x * right, y: left.y * right)
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
