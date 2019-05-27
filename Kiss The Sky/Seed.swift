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
    let baseWidth: CGFloat
    let tipWidth: CGFloat
    let spanLength: CGFloat
    let point1: Point
    let point2: Point
    let span: Span
    let restitution: CGFloat = 0.5
    var path = CGMutablePath()  // updated in renderSeeds()
    var shape = SKShapeNode()  // updated in renderSeeds()
    var opacity: CGFloat = 1.0

    init(/*parentFlower: Flower, zygoteGenotype: Genotype*/) {
        seedCount += 1
        self.id = seedCount
        self.baseWidth = initialSeedWidth
        self.tipWidth = baseWidth*0.35
        self.spanLength = baseWidth*1.6
        
        //if first generation, scatter...
        self.point1 = addPoint(at: CGPoint(x: CGFloat.random(in: screenWidth*0.2 ..< screenWidth*0.8), y: CGFloat.random(in: screenHeight*0.8 ..< screenHeight*0.95) ), radius: baseWidth/2 )
        self.point2 = addPoint(at: CGPoint(x: point1.position.x+spanLength, y: point1.position.y ), radius: tipWidth/2 )
        self.span = addSpan(connecting: point1, and: point2)
        point1.physicsBody?.velocity = CGVector(dx: CGFloat.random(in: -250...250), dy: CGFloat.random(in: -250...250))
        point2.physicsBody?.velocity = CGVector(dx: CGFloat.random(in: -250...250), dy: CGFloat.random(in: -250...250))
        
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
        
        //reference points & lengths
        let p1p: CGPoint = seed.point1.position  // point 1 position
        let p2p: CGPoint = seed.point2.position  // point 2 position
        let spl: CGFloat = seed.span.length  // span length
        let hbl: CGFloat = seed.baseWidth*0.85  // base handles length
        let htl: CGFloat = seed.tipWidth  // tip handles length
        
        //reference points (seed base & tip)
        let r1x: CGFloat = p1p.x - ( p2p.x - p1p.x ) * (seed.baseWidth*0.5 / spl)  // reference 1 x (seed base)
        let r1y: CGFloat = p1p.y - ( p2p.y - p1p.y ) * (seed.baseWidth*0.5 / spl)  // reference 1 y (seed base)
        let r2x: CGFloat = p2p.x + ( p2p.x - p1p.x ) * (seed.tipWidth*0.5 / spl)  // reference 2 x (seed tip)
        let r2y: CGFloat = p2p.y + ( p2p.y - p1p.y ) * (seed.tipWidth*0.5 / spl)  // reference 2 y (seed tip)
        
        //top bezier handles points
        let h1x: CGFloat = r1x + hbl * ( p1p.y - r1y ) / (seed.baseWidth*0.5);  // upper left handle
        let h1y: CGFloat = r1y - hbl * ( p1p.x - r1x ) / (seed.baseWidth*0.5);  // upper left handle
        let h2x: CGFloat = r2x - htl * ( p2p.y - r2y ) / (seed.tipWidth*0.5);  // upper right handle
        let h2y: CGFloat = r2y - htl * ( r2x - p2p.x ) / (seed.tipWidth*0.5);  // upper right handle
        
        //bottom bezier handles points
        let h3x: CGFloat = r2x + htl * ( p2p.y - r2y ) / (seed.tipWidth*0.5);  // lower right handle
        let h3y: CGFloat = r2y + htl * ( r2x - p2p.x ) / (seed.tipWidth*0.5);  // lower right handle
        let h4x: CGFloat = r1x - hbl * ( p1p.y - r1y ) / (seed.baseWidth*0.5);  // lower left handle
        let h4y: CGFloat = r1y + hbl * ( p1p.x - r1x ) / (seed.baseWidth*0.5);  // lower left handle
        
        //rendering
        seed.path.move(to: CGPoint(x: r1x, y: r1y))
        seed.path.addCurve(to: CGPoint(x: r2x, y: r2y),
                           control1: CGPoint(x: h1x, y: h1y),
                           control2: CGPoint(x: h2x, y: h2y))
        seed.path.move(to: CGPoint(x: r2x, y: r2y))
        seed.path.addCurve(to: CGPoint(x: r1x, y: r1y),
                           control1: CGPoint(x: h3x, y: h3y),
                           control2: CGPoint(x: h4x, y: h4y))
        seed.shape.path = seed.path
        seed.shape.fillColor = UIColor(red:73.0/255.0, green:5.0/255.0, blue:0.0/255.0, alpha: seed.opacity)
        seed.shape.lineWidth = screenWidth*0.001
        seed.shape.strokeColor = UIColor(red:0.0/255.0, green:0.0/255.0, blue:0.0/255.0, alpha: seed.opacity)
        seed.shape.glowWidth = seed.shape.lineWidth/5
        seed.shape.zPosition = 1
        shapes.append(seed.shape)
        
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
//✓    this.opacity = 1;
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
//✓        var p1 = seed.p1;
//✓        var p2 = seed.p2;
//✓        var sp = seed.sp;
//✓        var p1x = p1.cx;
//✓        var p1y = p1.cy;
//✓        var p2x = p2.cx;
//✓        var p2y = p2.cy;
//✓        var r1x = p1.cx - ( p2.cx - p1.cx ) * (p1.width*0.5 / sp.l );
//✓        var r1y = p1.cy - ( p2.cy - p1.cy ) * (p1.width*0.5 / sp.l );
//✓        var r2x = p2.cx + ( p2.cx - p1.cx ) * (p2.width*0.5 / sp.l );
//✓        var r2y = p2.cy + ( p2.cy - p1.cy ) * (p2.width*0.5 / sp.l );
//✓        var h1l = seed.sw*0.85;
//✓        var h2l = seed.sw*0.35;
//✓        var h1x = r1x + h1l * ( p1y - r1y ) / (p1.width*0.5);
//✓        var h1y = r1y - h1l * ( p1x - r1x ) / (p1.width*0.5);
//✓        var h2x = r2x - h2l * ( p2y - r2y ) / (p2.width*0.5);
//✓        var h2y = r2y - h2l * ( r2x - p2x ) / (p2.width*0.5);
//✓        var h3x = r2x + h2l * ( p2y - r2y ) / (p2.width*0.5);
//✓        var h3y = r2y + h2l * ( r2x - p2x ) / (p2.width*0.5);
//✓        var h4x = r1x - h1l * ( p1y - r1y ) / (p1.width*0.5);
//✓        var h4y = r1y + h1l * ( p1x - r1x ) / (p1.width*0.5);
//✓        ctx.strokeStyle = "rgba( 0, 0, 0, "+seed.opacity+" )";
//✓        ctx.fillStyle = "rgba( 73, 5, 0, "+seed.opacity+" )";
//✓        ctx.lineWidth = "1";
//✓        ctx.beginPath();
//✓        ctx.moveTo( r1x, r1y );
//✓        ctx.bezierCurveTo( h1x, h1y, h2x, h2y, r2x, r2y );
//✓        ctx.bezierCurveTo( h3x, h3y, h4x, h4y, r1x, r1y );
//✓        ctx.stroke();
//✓        ctx.fill();
//    }
//}
