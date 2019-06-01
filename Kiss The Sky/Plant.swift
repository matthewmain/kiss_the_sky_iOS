//
//  Plant.swift
//  Kiss The Sky
//
//  Created by Matthew Main on 5/28/19.
//  Copyright © 2019 Matthew Main. All rights reserved.
//

import SpriteKit



////////////////// PLANT //////////////////


var plants: [Plant] = []
var plantCount: Int = 0


class Plant {
    
    let id: Int
    let sourceSeed: Seed
    let generation: Int
        //let germinationYear: Int
    var xLocation: CGFloat?  // x value where plant is rooted to the ground
    var maxEnergyLevel: Int
        //let genotype: Genotype
        //let phenotype: Phenotype
        //let maxSegmentWidth: CGFloat
        //let maxSegmentWidth: CGFloat
        //let maxTotalSegments: Int
        //let stalkStrength: CGFloat
        //let firstLeafSegment: Int
        //let leafFrequency: Int
        //let maxLeafLength: CGFloat
        //var fh: CGFloat
        //var fl: CGFloat
        //var flowerColor: Dictionary
        //let forwardGrowthRate: CGFloat
        //let outwardGrowthRate: CGFloat
        //let leafGrowthRate: CGFloat
        //let leafArcHeight: CGFloat
        //var seedEnergy: CGFloat
        //var energy: CGFloat

    init( sourceSeed: Seed ) {
        plantCount += 1
        self.id = plantCount
        self.sourceSeed = sourceSeed
        self.generation = sourceSeed.generation
            //self.germinationYear = currentYear
        self.maxEnergyLevel = self.segmentCount * energyStoreFactor
            //self.genotype: Genotype = sourceSeed.genotype
            //self.phenotype: Phenotype = sourceSeed.phenotype
            //self.maxSegmentWidth = phenotype.maxSegmentWidthValue
            //self.maxSegmentWidth = phenotype.maxSegmentWidthValue  // maximum segment width (in pixels)
            //self.maxTotalSegments = phenotype.maxTotalSegmentsValue  // maximum total number of segments at maturity
            //self.stalkStrength = phenotype.stalkStrengthValue  // *if use, implement as <span>.spring.frequency (0.0-1.0)
            //self.firstLeafSegment = phenotype.firstLeafSegmentValue  // segment on which first leaf set grows
            //self.leafFrequency = phenotype.leafFrequencyValue  // number of segments until next leaf set
            //self.maxLeafLength = maxSegmentWidth * phenotype.maxLeafLengthValue  // maximum leaf length at maturity
            //self.fh = phenotype.flowerHueValue; if fh > 65 { fh += 100 }  // flower hue (omits greens)
            //self.fl = phenotype.flowerLightnessValue; if fl > 70 { fl += 25 }  // flower lightness
            //self.flowerColor = [ "h": fh, "l": fl }]  // flower color ( hue, lightness)
            //self.forwardGrowthRate = maxSegmentWidth*2  // rate of cross span increase per frame
            //self.outwardGrowthRate = forwardGrowthRate * CGFloat.random(in: 0.18...0.22) // rate forward span widens
            //self.leafGrowthRate = forwardGrowthRate * CGFloat.random(in: 1.4...1.6)  // leaf growth rate
            //self.leafArcHeight = CGFloat.random(in: 0.3...0.4)  // arc height (as ratio of leaf length)
            //self.seedEnergy = maxTotalSegments*275  // energy contained in seed
            //self.energy = seedEnergy  // energy (starts with seed energy at germination)
        }
    
    var sourceSeedHasBeenRemoved: Bool = false
    var age: Int = 0  // plant age in worldtime units (frames)
    var segments: [Segment] = []
    var segmentCount: Int = 0
        //var flower: Flower? = nil
    var hasFlowers: Bool = false
    var pollenPadColor: Dictionary = color["pp"]!  // pollen pad color
    var isAlive: Bool = true
    var hasBeenEliminatedByPlayer: Bool = false
        //var hasReachedOldAge: Bool = false
        //var oldAgeReduction: CGFloat = 0  // energy reduction per plant iteration, when plant is dying of old age
    var hasCollapsed: Bool = false
    var isActive: Bool = true  // inactive plants are rendered but ignored by plant & light iterations
    var hasDecomposed: Bool = false  // decomposed plants are compressed to floor y-value and ready to be removed
    var opacity: CGFloat = 1
    var hasBeenRemoved: Bool = false
    var ptB1: Point? = nil  // base point 1
    var ptB2: Point? = nil  // base point 2
    var spB: Span? = nil  // adds base span
        //let maxFlowerBaseWidth: CGFloat = 1  // max flower base width, in units of plant maxSegmentWidth
        //let flowerBudHeight: CGFloat = 1  // bud height (from hex top, in units of hex heights)

}



func createPlant(sourceSeed: Seed) -> Plant {
    var newPlant: Plant?
    if sourceSeed.generation == 1 { // if seed is initiating seed, adds new plant to end of the plants array
        plants.append( Plant(sourceSeed: sourceSeed) )
        newPlant = plants[plants.count-1]
    } else {
        for plant in plants {  // if not initiating seed, adds new plant before parent in plants array
            if sourceSeed.parentPlantId == plant.id {
                //plants.splice( i, 0, new Plant( sourceSeed ) );
                newPlant = plant
            }
        }
    }
    return newPlant!
}



func growPlants() {
    for plant in plants {
//        let p = plant
//        if ( p.isActive ) {
//            p.age++;
        if ( !plant.sourceSeed.hasGerminated ) {
            handleSeedUntilGermination(seed: plant.sourceSeed)
        } /* else if ( !p.sourceSeedHasBeenRemoved ) { */
//                hideAndRemoveSeed( p.sourceSeed );
//            }
//            if ( p.energy > p.segmentCount*energyStoreFactor && p.energy>p.seedEnergy ) {
//                p.energy = p.segmentCount*energyStoreFactor;  // caps plant max energy level based on segment count
//            }
//            if ( p.hasFlowers ) {
//                for ( var j=0; j<p.flowers.length; j++ ) {
//                    var flower = p.flowers[j];
//                    developFlower( p, flower );
//                    if ( flower.ageSinceBlooming > oldAgeMarker ) {  // plant starts dying of old age
//                        p.hasReachedOldAge = true;
//                    }
//                }
//            }
//            if ( p.energy > 0 || !restrictGrowthByEnergy && !p.hasReachedOldAge ) {
//                for (var k=0; k<p.segments.length; k++) {
//                    var s = p.segments[k];
//                    if ( s.spF.l < p.maxSegmentWidth ) {
//                        lengthenSegmentSpans( p, s );
//                        p.energy -= s.spCd.l * groEnExp;  // reduces energy by segment width while growing
//                    }
//                    if ( readyForChildSegment( p, s ) ) {
//                        createSegment( p, s, s.ptE1, s.ptE2 );
//                    }
//                    if ( !s.hasLeaves ) {
//                        generateLeavesWhenReady( p, s );
//                    } else if ( s.spLf1.l < p.maxLeafLength ) {
//                        growLeaves( p, s );
//                        p.energy -= s.spLf1.l*groEnExp;  // reduces energy by one leaf length while leaves growing
//                    }
//                    if ( !p.hasFlowers && readyForFlower( p, s ) ) {
//                        createFlower( p, s, s.ptE1, s.ptE2 );
//                    }
//                }
//            }
//            if ( p.hasReachedOldAge ) {
//                p.oldAgeReduction += oldAgeRate;
//                p.energy -= p.oldAgeReduction;
//            }
//            if ( p.sourceSeed.hasGerminated ) {
//                p.energy -= p.segmentCount * livEnExp;  // cost of living: reduces energy by a ratio of segment count
//            }
//            if ( p.isAlive && p.energy < p.maxEnergyLevel*deathEnergyLevelRatio && restrictGrowthByEnergy ) {
//                killPlant( p );  // plant dies if energy level falls below minimum to be alive
//            }
//            if ( !p.hasCollapsed && p.energy<p.maxEnergyLevel*collapseEnergyLevelRatio && restrictGrowthByEnergy ) {
//                collapsePlant( p );  // plant collapses if energy level falls below minimum to stay standing
//                p.isActive = false;  // removes plant from local plant iterations
//            }
//        } else if ( p.hasCollapsed && currentYear - p.germinationYear >= 1 ) {
//            decomposePlant( p );
//        }
//        if ( p.hasDecomposed && !p.hasBeenRemoved) {
//            fadePlantOutAndRemove( p );
//        }
        
        //track previous seed positions (refactor/move this)
        plant.sourceSeed.point1PreviousPosition = plant.sourceSeed.point1.position
        plant.sourceSeed.point2PreviousPosition = plant.sourceSeed.point2.position

    }
}

