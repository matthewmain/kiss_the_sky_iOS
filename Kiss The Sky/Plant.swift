//
//  Plant.swift
//  Kiss The Sky
//
//  Created by Matthew Main on 5/28/19.
//  Copyright © 2019 Matthew Main. All rights reserved.
//


import SpriteKit



var plants: [Plant] = []
var plantCount: Int = 0



class Plant {
    
    let id: Int
    let sourceSeed: Seed
    let generation: Int
    
    init( sourceSeed: Seed ) {
        plantCount += 1
        self.id = plantCount
        self.sourceSeed = sourceSeed
        self.generation = sourceSeed.generation
    }
    
    var sourceSeedHasGerminated: Bool = false
    var sourceSeedHasBeenRemoved: Bool = false
//    this.germinationYear = currentYear;  // germination year
//    this.age = 0;  // plant age in worldtime units
//    this.segments = []; this.segmentCount = 0;
//    this.flowers = []; this.flowerCount = 0;
//    this.xLocation = null;
//    this.maxEnergyLevel = this.segmentCount * energyStoreFactor;
//    this.hasFlowers = false;
//    this.pollenPadColor = C.pp;  // pollen pad color
//    this.isAlive = true;
//    this.hasBeenEliminatedByPlayer = false;
//    this.hasReachedOldAge = false;
//    this.oldAgeReduction = 0;  // (energy reduction per plant iteration, when plant is dying of old age)
//    this.hasCollapsed = false;
//    this.isActive = true;  // (inactive plants are rendered but ignored by all other local plant & light iterations)
//    this.hasDecomposed = false;  // decomposed plants are compressed to floor y-value and ready to be removed
//    this.opacity = 1;
//    this.hasBeenRemoved = false;
//    //base segment (values assigned at source seed germination)
//    this.xLocation = null;  // x value where plant is rooted to the ground
//    this.ptB1 = null;  // base point 1
//    this.ptB2 = null;  // base point 2
//    this.spB = null;  // adds base span
//    //genes
//    this.genotype = this.sourceSeed.genotype;
//    this.phenotype = this.sourceSeed.phenotype;
//    var ph = this.phenotype;
//    this.maxSegmentWidth = ph.maxSegmentWidthValue;  // maximum segment width (in pixels)
//    this.maxTotalSegments = ph.maxTotalSegmentsValue;  // maximum total number of segments at maturity
//    this.stalkStrength = ph.stalkStrengthValue;
//    this.firstLeafSegment = ph.firstLeafSegmentValue;  // (segment on which first leaf set grows)
//    this.leafFrequency = ph.leafFrequencyValue;  // (number of segments until next leaf set)
//    this.maxLeafLength = this.maxSegmentWidth * ph.maxLeafLengthValue;  // maximum leaf length at maturity
//    this.fh = ph.flowerHueValue; if ( this.fh > 65 ) { this.fh += 100; }  // flower hue (omits greens)
//    this.fl = ph.flowerLightnessValue; if ( this.fl > 70 ) { this.fl += 25; }  // flower lightness
//    //gene combinations
//    this.flowerColor = { h: this.fh, l: this.fl };  // flower color ( hue, lightness)
//    //non-gene qualities
//    this.forwardGrowthRate = gravity * this.maxSegmentWidth*2;  // (rate of cross span increase per frame)
//    this.outwardGrowthRate = this.forwardGrowthRate * Tl.rfb(0.18,0.22);  // (rate forward span widens / frame)
//    this.leafGrowthRate = this.forwardGrowthRate * Tl.rfb(1.4,1.6);  // leaf growth rate
//    this.leafArcHeight = Tl.rfb(0.3,0.4);  // arc height (as ratio of leaf length)
//    this.maxFlowerBaseWidth = 1;  // max flower base width, in units of plant maxSegmentWidth
//    this.flowerBudHeight = 1;  // bud height ( from hex top, in units of hex heights )
//    //energy
//    this.seedEnergy = this.maxTotalSegments*275;  // energy contained in seed
//    this.energy = this.seedEnergy;  // energy (starts with seed energy at germination)
    
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
        if ( !plant.sourceSeedHasGerminated ) {
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
//            if ( p.sourceSeedHasGerminated ) {
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

