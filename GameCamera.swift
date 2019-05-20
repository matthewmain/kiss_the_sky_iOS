//
//  GameCamera.swift
//  Kiss The Sky
//
//  Created by Matthew Main on 5/20/19.
//  Copyright © 2019 Matthew Main. All rights reserved.
//

import SpriteKit

class GameCamera: SKCameraNode {
    
    func setConstraints(with scene: SKScene, and frame: CGRect, to node: SKNode?) {
        let scaledSize = CGSize(width: scene.size.width * xScale, height: scene.size.height * yScale)  // zoom factor as scaled size
        let boardContentRect = frame  // a virtual rectangle that matches the device screen
        
        // don't zoom out past scene borders
        let xInset = min(scaledSize.width / 2, boardContentRect.width / 2)
        let yInset = min(scaledSize.height / 2, boardContentRect.height / 2)
        let insetContentRect = boardContentRect.insetBy(dx: xInset, dy: yInset)
        
        // don't pan past the scene borders
        let xRange = SKRange(lowerLimit: insetContentRect.minX, upperLimit: insetContentRect.maxX)
        let yRange = SKRange(lowerLimit: insetContentRect.minY, upperLimit: insetContentRect.maxY)
        let levelEdgeConstraint = SKConstraint.positionX(xRange, y: yRange)
        
        constraints = [levelEdgeConstraint]
    }

}
