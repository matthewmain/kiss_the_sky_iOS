//
//  Renderer.swift
//  Kiss The Sky
//
//  Created by Matthew Main on 5/26/19.
//  Copyright © 2019 Matthew Main. All rights reserved.
//


import SpriteKit
import CoreGraphics


var shapes: [SKShapeNode] = []


func render() {
    
    shapes = []  // clears last frame's shapes from collection array

    renderSeeds()
    
}


