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

    for seed in seeds {
        seed.path = CGMutablePath()  // clears previous path
        seed.path.addArc(center: seed.point1.position, radius: seed.width/2, startAngle: 0, endAngle: .pi*2, clockwise: true)  // sets new path based on updated position
        seed.shape.path = seed.path  // sets new shape
        shapes.append(seed.shape)  // appends new shape to shapes collection
        seed.shape.fillColor = .red
        seed.shape.lineWidth = 0.5
        seed.shape.strokeColor = .black
        seed.shape.glowWidth = 0.2
        seed.shape.zPosition = 1
    }
    
}








///////// JS /////////

//        function renderSeed( resultingPlant ) {
//            if ( !resultingPlant.sourceSeedHasBeenRemoved ) {
//                var seed = resultingPlant.sourceSeed;
//                //point instances (centers of the two component circles)
//                var p1 = seed.p1;
//                var p2 = seed.p2;
//                var sp = seed.sp;
//                var p1x = p1.cx;
//                var p1y = p1.cy;
//                var p2x = p2.cx;
//                var p2y = p2.cy;
//                //references points (polar points)
//                var r1x = p1.cx - ( p2.cx - p1.cx ) * (p1.width*0.5 / sp.l );
//                var r1y = p1.cy - ( p2.cy - p1.cy ) * (p1.width*0.5 / sp.l );
//                var r2x = p2.cx + ( p2.cx - p1.cx ) * (p2.width*0.5 / sp.l );
//                var r2y = p2.cy + ( p2.cy - p1.cy ) * (p2.width*0.5 / sp.l );
//                //bezier handle lengths
//                var h1l = seed.sw*0.85;
//                var h2l = seed.sw*0.35;
//                //top bezier handles points
//                var h1x = r1x + h1l * ( p1y - r1y ) / (p1.width*0.5);
//                var h1y = r1y - h1l * ( p1x - r1x ) / (p1.width*0.5);
//                var h2x = r2x - h2l * ( p2y - r2y ) / (p2.width*0.5);
//                var h2y = r2y - h2l * ( r2x - p2x ) / (p2.width*0.5);
//                //bottom bezier handles points
//                var h3x = r2x + h2l * ( p2y - r2y ) / (p2.width*0.5);
//                var h3y = r2y + h2l * ( r2x - p2x ) / (p2.width*0.5);
//                var h4x = r1x - h1l * ( p1y - r1y ) / (p1.width*0.5);
//                var h4y = r1y + h1l * ( p1x - r1x ) / (p1.width*0.5);
//                //rendering
//                ctx.strokeStyle = "rgba( 0, 0, 0, "+seed.opacity+" )";
//                ctx.fillStyle = "rgba( 73, 5, 0, "+seed.opacity+" )";
//                ctx.lineWidth = "1";
//                ctx.beginPath();
//                ctx.moveTo( r1x, r1y );
//                ctx.bezierCurveTo( h1x, h1y, h2x, h2y, r2x, r2y );
//                ctx.bezierCurveTo( h3x, h3y, h4x, h4y, r1x, r1y );
//                ctx.stroke();
//                ctx.fill();
//            }
//        }
