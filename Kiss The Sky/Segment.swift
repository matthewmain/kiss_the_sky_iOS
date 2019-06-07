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
    let id: Int
    let plantId: Int
    let parentSegmentId: Int?
    let isBaseSegment: Bool
    let forwardGrowthRateVariation: CGFloat
    let ptB1: Point
    let ptB2: Point
    let origin: CGPoint
    let ptE1: Point
    let ptE2: Point
    let spL: Span
    let spR: Span
    let spF: Span
    let spCd: Span
    let spCu: Span
    var spCdP: Span?
    var spCuP: Span?
        //var skins: [Skin] = []  // (*omit segment skins in favor a single stalk path)
    init( plant: Plant, parentSegment: Segment?, basePoint1: Point, basePoint2: Point ) {
        self.id = plant.segmentCount
        self.plantId = plant.id
        self.parentSegmentId = parentSegment != nil ? parentSegment!.id : nil
        self.isBaseSegment = parentSegment != nil ? false : true
        self.forwardGrowthRateVariation = CGFloat.random(in: 0.97...1.03)  // for left & right span length variation
        self.ptB1 = basePoint1  // base point 1
        self.ptB2 = basePoint2  // base point 2
        self.origin = CGPoint(x: (ptB1.position.x + ptB2.position.x)/2,
                              y: (ptB1.position.y + ptB2.position.y)/2) // new segment origin between base points
        self.ptE1 = addPoint(at: origin)  // extension point 1 (*may need to offset as in the original JS)
        self.ptE2 = addPoint(at: origin)  // extension point 2 (*may need to offset as in the original JS)
        self.spL = addSpan(connecting: ptB1, and: ptE1) // left span
        self.spR = addSpan(connecting: ptB2, and: ptE2)  // right span
        self.spF = addSpan(connecting: ptE1, and: ptE2)  // forward span
        self.spCd = addSpan(connecting: ptE1, and: ptB2) // downward (l to r) cross span
        self.spCu = addSpan(connecting: ptB1, and: ptE2) // upward (l to r) cross span
            //spL.spring.frequency = plant.stalkStrength
            //spR.spring.frequency = plant.stalkStrength
            //spF.spring.frequency = plant.stalkStrength
            //spCd.spring.frequency = plant.stalkStrength
            //spCu.spring.frequency = plant.stalkStrength
        if (!isBaseSegment) {
            self.spCdP = addSpan(connecting: ptE1, and: parentSegment!.ptB2) // downward (l to r) cross span to parent
            self.spCuP = addSpan(connecting: parentSegment!.ptB1, and: ptE2) // upward (l to r) cross span to parent
                //spCdP.spring.frequency = plant.stalkStrength
                //spCuP.spring.frequency = plant.stalkStrength
        }
    }
    var hasChild: Bool = false
    var hasLeaves: Bool = false
    var hasLeafScaffolding: Bool = false
        //var mass: CGFloat = 1  // mass of the segment stalk portion ( divided between the two extension points)
    var ptLf1: Point? = nil  // leaf point 1 (leaf tip)
    var ptLf2: Point? = nil  // leaf point 2 (leaf tip)
    var spLf1: Point? = nil  // leaf 1 Span
    var spLf2: Point? = nil  // leaf 2 Span
    var clS: Dictionary = color["hdf"]!  // stalk color (dark green when healthy)
    var clO: Dictionary = color["hol"]!  // outline color (very dark brown when healthy)
    var clI: Dictionary = color["hil"]!  // inner line color (slightly darker green than leaf fill when healthy)
    var clL: Dictionary = color["hlf"]!  // leaf color (green when healthy)
    var clLS: Dictionary = color["hls"]!  // leaf shadow color (barely opaque black when healthy)
}



func createSegment(plant: Plant, parentSegment: Segment?, basePoint1: Point, basePoint2: Point) {
    plant.segmentCount += 1
    plant.maxEnergyLevel = plant.segmentCount * energyStoreFactor
    plant.segments.insert( Segment( plant: plant, parentSegment: parentSegment, basePoint1: basePoint1, basePoint2: basePoint2 ), at: 0)
    if (parentSegment != nil) { parentSegment!.hasChild = true }
}


