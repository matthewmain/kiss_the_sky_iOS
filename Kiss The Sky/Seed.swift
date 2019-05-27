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
    var path = CGMutablePath()  // updated in Renderer.swift
    var shape = SKShapeNode()  // // updated in Renderer.swift

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
