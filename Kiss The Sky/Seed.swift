//
//  Seed.swift
//  Kiss The Sky
//
//  Created by Matthew Main on 5/25/19.
//  Copyright © 2019 Matthew Main. All rights reserved.
//

import SpriteKit



////////////////// SEED //////////////////


var seeds: [Seed] = []
var seedCount: Int = 0

var initialSeedWidth: CGFloat = screenHeight*0.014
var seedRestitution: CGFloat = 0.5


class Seed {

    let id: Int
    let parentPlantId: Int?
    var resultingPlantId: Int?
    let generation: Int
        //let genotype: Genotype
        //let phenotype: Phenotype
    let point1: Point
    let point2: Point
    let span: Span
    let baseWidth: CGFloat
    let tipWidth: CGFloat
    let spanLength: CGFloat
    var point1PreviousPosition: CGPoint?
    var point2PreviousPosition: CGPoint?
    
    init(parentPlant: Plant?/*, zygoteGenotype: Genotype*/) {
        seedCount += 1
        self.id = seedCount
//        if parentPlant != nil {
//            self.parentPlantId = parentPlant!.id
//            self.generation = parentPlant!.generation + 1
//            //this.sw = Tl.obById( Tl.obById( plants, this.parentPlantId ).flowers, this.parentFlowerId ).spHcH.l/2;  // seed width
//            //var p1 = spanMidPoint( Tl.obById( Tl.obById( plants, this.parentPlantId ).flowers, this.parentFlowerId ).spHbM );  // positions seed p1 at bottom of parent flower's hex
//            //this.p1 = addPt( pctFromXVal(p1.x), pctFromYVal(p1.y) );  // seed point 1
//            //var p2 = spanMidPoint( Tl.obById( Tl.obById( plants, this.parentPlantId ).flowers, this.parentFlowerId ).spHtM );  // positions seed p2 at top of parent flower's hex
//            //this.p2 = addPt( pctFromXVal(p2.x), pctFromYVal(p2.y) );  // seed point 2
//            //this.generation = Tl.obById( Tl.obById( plants, this.parentPlantId ).flowers, this.parentFlowerId ).generation + 1;
//        } else {
            self.parentPlantId = nil
            self.generation = 1
            self.baseWidth = initialSeedWidth
            self.tipWidth = baseWidth*0.35
            self.spanLength = baseWidth*1.6
            self.point1 = addPoint(at: CGPoint(x: CGFloat.random(in: screenWidth*0.2 ..< screenWidth*0.8), y: CGFloat.random(in: screenHeight*0.8 ..< screenHeight*0.95) ), radius: baseWidth/2 )
            self.point2 = addPoint(at: CGPoint(x: point1.position.x+spanLength, y: point1.position.y ), radius: tipWidth/2 )
            self.span = addSpan(connecting: point1, and: point2)
            point1.physicsBody?.velocity = CGVector(dx: CGFloat.random(in: -250...250), dy: CGFloat.random(in: -250...250))
            point2.physicsBody?.velocity = CGVector(dx: CGFloat.random(in: -250...250), dy: CGFloat.random(in: -250...250))
            point1.physicsBody?.restitution = seedRestitution
            point2.physicsBody?.restitution = seedRestitution
//        }
        //self.genotype = zygoteGenotype
        //self.phenotype = generatePhenotype(self.genotype)
        self.resultingPlantId = createPlant(sourceSeed: self).id
    }
    
    var opacity: CGFloat = 1.0
    var path: CGMutablePath = CGMutablePath()  // updated in renderSeeds()
    var shape: SKShapeNode = SKShapeNode()  // updated in renderSeeds()
    var hasLanded: Bool = false
    var isPlanted: Bool = false
    var hasGerminated: Bool = false
    
}



func createSeed(parentPlant: Plant?/*, zygoteGenotype: Genotype*/) /*-> Seed*/ {
    seeds.append( Seed(parentPlant: parentPlant/*, zygoteGenotype: zygoteGenotype*/) )
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
        seed.shape.lineWidth = screenHeight*0.001
        seed.shape.strokeColor = UIColor(red:0.0/255.0, green:0.0/255.0, blue:0.0/255.0, alpha: seed.opacity)
        seed.shape.glowWidth = seed.shape.lineWidth/5
        seed.shape.zPosition = 1
        shapes.append(seed.shape)
    }
}



func handleSeedUntilGermination(seed: Seed) {
    if !seed.hasLanded {
        //prevent seed from falling through floor on initial tumble
        if seed.point1.position.y < seed.baseWidth/2 { seed.point1.position.y = seed.baseWidth/2 }
        if seed.point2.position.y < seed.tipWidth/2 { seed.point2.position.y = seed.tipWidth/2 }
        //plant seed once it settles onto the ground
        let p1OnGround: Bool = seed.point1.position.y < seed.baseWidth
        let p2OnGround: Bool = seed.point2.position.y < seed.tipWidth
        let p1Stable: Bool = seed.point1PreviousPosition == seed.point1.position
        let p2Stable: Bool = seed.point2PreviousPosition == seed.point2.position
        if !seed.isPlanted && (p1OnGround || p2OnGround) && (p1Stable || p2Stable) {
            seed.hasLanded = true
        }
    } else if !seed.isPlanted {
        //plant seed once it's landed
        plantSeed(seed: seed)
    } else if !seed.hasGerminated /*&& currentSeason === "Spring"*/ {
        //germinate seed once it's planted
        germinateSeed(seed: seed)
    }
}



func plantSeed(seed: Seed) {
    seed.point1.physicsBody?.isDynamic = false
    seed.point2.physicsBody?.linearDamping = 90
    seed.point1.physicsBody?.collisionBitMask = nothingCollisionCategory
    seed.point2.physicsBody?.collisionBitMask = nothingCollisionCategory
    if seed.point1.position.y > seed.baseWidth*0.1 {
        seed.point1.position.y -= 0.05
    } else {
        seed.isPlanted = true
    }
}



func germinateSeed(seed: Seed) {
    let plant: Plant? = plants.first { $0.id == seed.resultingPlantId }
    //    plant.xLocation = pctFromXVal( seed.p1.cx );
    //    plant.ptB1 = addPt( plant.xLocation - 0.1, 100 );  // base point 1
    //    plant.ptB2 = addPt( plant.xLocation + 0.1, 100 );  // base point 2
    //    plant.ptB1.fixed = plant.ptB2.fixed = true;  // fixes base points to ground
    //    plant.spB = addSp( plant.ptB1.id, plant.ptB2.id );  // adds base span
    //    createSegment( plant, null, plant.ptB1, plant.ptB2 );  // creates the base segment (with "null" parent)
    seed.hasGerminated = true
    plant!.sourceSeedHasGerminated = true
    //    plant.germinationYear = currentYear;
}


