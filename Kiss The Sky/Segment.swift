//
//  Segment.swift
//  Kiss The Sky
//
//  Created by Matthew Main on 5/31/19.
//  Copyright © 2019 Matthew Main. All rights reserved.
//

import SpriteKit



////////////////// SEGMENT //////////////////


class Segment {
    
//    ///plant stalk segment constructor
//    function Segment( plant, parentSegment, basePoint1, basePoint2 ) {
//    this.plantId = plant.id;
//    this.id = plant.segmentCount;
//    this.hasChild = false;
//    this.parentSegmentId = parentSegment === null ? null : parentSegment.id;
//    this.isBaseSegment = false; if (parentSegment === null) { this.isBaseSegment = true; }
//    this.hasLeaves = false;
//    this.hasLeafScaffolding = false;
//    //settings
//    this.forwardGrowthRateVariation = Tl.rfb(0.97,1.03);  // for left & right span length variation
//    this.mass = 1;  // mass of the segment stalk portion ( divided between the two extension points)
//    //base points
//    this.ptB1 = basePoint1;  // base point 1
//    this.ptB2 = basePoint2;  // base point 2
//    //extension points
//    var originX = ( this.ptB1.cx + this.ptB2.cx ) / 2;  // center of base points x values
//    var originY = ( this.ptB1.cy + this.ptB2.cy ) / 2;  // center of base points y values
//    this.ptE1 = addPt( pctFromXVal( originX ) - 0.1, pctFromYVal( originY ) - 0.1 );  // extension point 1
//    this.ptE2 = addPt( pctFromXVal( originX ) + 0.1, pctFromYVal( originY ) - 0.1 );  // extension point 2
//    this.ptE1.mass = this.mass / 2;
//    this.ptE2.mass = this.mass / 2;
//    //spans
//    this.spL = addSp( this.ptB1.id, this.ptE1.id );  // left span
//    this.spR = addSp( this.ptB2.id, this.ptE2.id );  // right span
//    this.spF = addSp( this.ptE1.id, this.ptE2.id );  // forward span
//    this.spCd = addSp( this.ptE1.id, this.ptB2.id );  // downward (l to r) cross span
//    this.spCu = addSp( this.ptB1.id, this.ptE2.id );  // upward (l to r) cross span
//    if (!this.isBaseSegment) {
//    this.spCdP = addSp( this.ptE1.id, parentSegment.ptB2.id ); // downward (l to r) cross span to parent
//    this.spCuP = addSp( parentSegment.ptB1.id, this.ptE2.id ); // upward (l to r) cross span to parent
//    this.spCdP.strength = plant.stalkStrength;
//    this.spCuP.strength = plant.stalkStrength;
//    }
//    this.spL.strength = plant.stalkStrength;
//    this.spR.strength = plant.stalkStrength;
//    this.spF.strength = plant.stalkStrength;
//    this.spCd.strength = plant.stalkStrength;
//    this.spCu.strength = plant.stalkStrength;
//    //skins
//    this.skins = [];
//    this.skins.push( addSk( [ this.ptE1.id, this.ptE2.id, this.ptB2.id, this.ptB1.id ], null ) );
//    //leaves
//    this.ptLf1 = null;  // leaf point 1 (leaf tip)
//    this.ptLf2 = null;  // leaf point 2 (leaf tip)
//    this.spLf1 = null;  // leaf 1 Span
//    this.spLf2 = null;  // leaf 2 Span
//    //colors
//    this.clS = C.hdf;  // stalk color (dark green when healthy)
//    this.clO = C.hol;  // outline color (very dark brown when healthy)
//    this.clI = C.hil;  // inner line color (slightly darker green than leaf fill when healthy)
//    this.clL = C.hlf;  // leaf color (green when healthy)
//    this.clLS = C.hls;  // leaf shadow color (barely opaque black when healthy)
//    }
    
}



func createSegment(plant: Plant, parentSegment: Segment, basePoint1: Point, basePoint2: Point) {
    
//    function createSegment( plant, parentSegment, basePoint1, basePoint2 ) {
//        plant.segmentCount++;
//        plant.maxEnergyLevel = plant.segmentCount * energyStoreFactor;
//        plant.segments.unshift( new Segment( plant, parentSegment, basePoint1, basePoint2 ) );
//        if (parentSegment !== null) {
//            //parentSegment.child = plant.segments[0];
//            parentSegment.hasChild = true;
//        }
//    }
    
}
