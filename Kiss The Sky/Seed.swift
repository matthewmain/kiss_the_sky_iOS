//
//  Seed.swift
//  Kiss The Sky
//
//  Created by Matthew Main on 5/25/19.
//  Copyright © 2019 Matthew Main. All rights reserved.
//


import SpriteKit


var seeds: [Seed] = []
var seedCount: Int = 0

var initialSeedWidth: CGFloat = screenWidth*0.014


class Seed {

    let id: Int
    let width: CGFloat
    let point1: Point
    let point2: Point
    let span: Span
    let restitution: CGFloat = 0.5
    var path = CGMutablePath()  // updated in renderSeeds()
    var shape = SKShapeNode()  // // updated in renderSeeds()

    init(/*parentFlower: Flower, zygoteGenotype: Genotype*/) {
        seedCount += 1
        self.id = seedCount
        self.width = initialSeedWidth
        self.point1 = addPoint(at: CGPoint(x: CGFloat.random(in: screenWidth*0.2 ..< screenWidth*0.8), y: CGFloat.random(in: screenHeight*0.8 ..< screenHeight*0.95) ), radius: width/2 )
        self.point2 = addPoint(at: CGPoint(x: point1.position.x+width*1.6, y: point1.position.y ), radius: width*0.35/2 )
        self.span = addSpan(connecting: point1, and: point2)
        point1.physicsBody?.restitution = restitution
        point2.physicsBody?.restitution = restitution
    }

}


func createSeed(/*parentFlower: Flower, zygoteGenotype: Genotype*/) /*-> Seed*/ {
    seeds.append( Seed(/*parentFlower: Flower, zygoteGenotype: Genotype*/) )
    //return seeds[seeds.count-1]
}


func renderSeeds() {
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








////////// JS ////////////

//    function Seed( parentFlower, zygoteGenotype ) {
//X    this.saveTagClass = "seed";
//✓    this.id = seedCount;
//    this.parentFlowerId = parentFlower === null ? null : parentFlower.id;
//    this.parentPlantId = parentFlower === null ? null : parentFlower.plantId;
//    if ( parentFlower === null ) {
//✓    this.sw = 14;  // seed width
//✓    this.p1 = addPt( Tl.rib(33,66), Tl.rib(5,25) );  // seed point 1 (placed in air for scattering at initiation)
//✓    this.p2 = addPt( pctFromXVal( this.p1.cx + this.sw*1.6 ), pctFromYVal( this.p1.cy ) );  // seed point 2
//    this.generation = 1;
//    } else {
//    this.sw = Tl.obById( Tl.obById( plants, this.parentPlantId ).flowers, this.parentFlowerId ).spHcH.l/2;  // seed width
//    var p1 = spanMidPoint( Tl.obById( Tl.obById( plants, this.parentPlantId ).flowers, this.parentFlowerId ).spHbM );  // positions seed p1 at bottom of parent flower's hex
//    this.p1 = addPt( pctFromXVal(p1.x), pctFromYVal(p1.y) );  // seed point 1
//    var p2 = spanMidPoint( Tl.obById( Tl.obById( plants, this.parentPlantId ).flowers, this.parentFlowerId ).spHtM );  // positions seed p2 at top of parent flower's hex
//    this.p2 = addPt( pctFromXVal(p2.x), pctFromYVal(p2.y) );  // seed point 2
//    this.generation = Tl.obById( Tl.obById( plants, this.parentPlantId ).flowers, this.parentFlowerId ).generation + 1;
//    }
//    this.genotype = zygoteGenotype;
//    this.phenotype = EV.generatePhenotype( this.genotype );
//✓    this.p1.width = this.sw*1;
//    this.p1.mass = 5;
//✓    this.p2.width = this.sw*0.35; this.p2.mass = 5;
//✓    this.sp = addSp( this.p1.id, this.p2.id );  // seed span
//    this.sp.strength = 2;
//    this.opacity = 1;
//    this.planted = false;
//    this.hasGerminated = false;
//    this.resultingPlantId = createPlant( this ).id;
//    }
    

//function createSeed( parentFlower, zygoteGenotype ) {
//✓    seedCount++;
//✓    seeds.push( new Seed( parentFlower, zygoteGenotype ) );
//    if ( parentFlower !== null ) { parentFlower.seeds.push( seeds[seeds.length-1] ); }
//    return seeds[seeds.length-1];
//}


//function renderSeed( resultingPlant ) {
//    if ( !resultingPlant.sourceSeedHasBeenRemoved ) {
//        var seed = resultingPlant.sourceSeed;
//        //point instances (centers of the two component circles)
//        var p1 = seed.p1;
//        var p2 = seed.p2;
//        var sp = seed.sp;
//        var p1x = p1.cx;
//        var p1y = p1.cy;
//        var p2x = p2.cx;
//        var p2y = p2.cy;
//        //references points (polar points)
//        var r1x = p1.cx - ( p2.cx - p1.cx ) * (p1.width*0.5 / sp.l );
//        var r1y = p1.cy - ( p2.cy - p1.cy ) * (p1.width*0.5 / sp.l );
//        var r2x = p2.cx + ( p2.cx - p1.cx ) * (p2.width*0.5 / sp.l );
//        var r2y = p2.cy + ( p2.cy - p1.cy ) * (p2.width*0.5 / sp.l );
//        //bezier handle lengths
//        var h1l = seed.sw*0.85;
//        var h2l = seed.sw*0.35;
//        //top bezier handles points
//        var h1x = r1x + h1l * ( p1y - r1y ) / (p1.width*0.5);
//        var h1y = r1y - h1l * ( p1x - r1x ) / (p1.width*0.5);
//        var h2x = r2x - h2l * ( p2y - r2y ) / (p2.width*0.5);
//        var h2y = r2y - h2l * ( r2x - p2x ) / (p2.width*0.5);
//        //bottom bezier handles points
//        var h3x = r2x + h2l * ( p2y - r2y ) / (p2.width*0.5);
//        var h3y = r2y + h2l * ( r2x - p2x ) / (p2.width*0.5);
//        var h4x = r1x - h1l * ( p1y - r1y ) / (p1.width*0.5);
//        var h4y = r1y + h1l * ( p1x - r1x ) / (p1.width*0.5);
//        //rendering
//        ctx.strokeStyle = "rgba( 0, 0, 0, "+seed.opacity+" )";
//        ctx.fillStyle = "rgba( 73, 5, 0, "+seed.opacity+" )";
//        ctx.lineWidth = "1";
//        ctx.beginPath();
//        ctx.moveTo( r1x, r1y );
//        ctx.bezierCurveTo( h1x, h1y, h2x, h2y, r2x, r2y );
//        ctx.bezierCurveTo( h3x, h3y, h4x, h4y, r1x, r1y );
//        ctx.stroke();
//        ctx.fill();
//    }
//}
