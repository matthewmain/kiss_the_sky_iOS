//
//  Settings.swift
//  Kiss The Sky
//
//  Created by Matthew Main on 5/24/19.
//  Copyright © 2019 Matthew Main. All rights reserved.
//

import SpriteKit



////////////////// SETTINGS //////////////////


//user settings
var viewShadows: Bool = true

// performance
let renderFactor: Int = 3  // factor of physics iterations when scenes are rendered (less is more frequent)

//collisions
let nothingCollisionCategory: UInt32 = 0b0000
let screenEdgesCollisionCategory: UInt32 = 0b0001
let solidMoveableObjectsCollisionCategory: UInt32 = 0b0010

//development
let viewDeviceFramesVisualizer: Bool = false
var viewStalks: Bool = true
var viewLeaves: Bool = true
var viewFlowers: Bool = true
var viewPods: Bool = true
var viewRedFlowerIndicator: Bool = true
var viewPollenBursts: Bool = true
var viewPollinatorLines: Bool = true
var viewPollinationGlow: Bool = true
var runPollinationAnimations: Bool = true

//plant life cycle
var allowSelfPollination: Bool = true
var pollinationFrequency: Int = 5  // as average number of pollination events per open flower per length of summer
var maxSeedsPerFlowerRatio: CGFloat = 0.333  // max seeds per flower (as ratio of plant's max total segments)
var restrictGrowthByEnergy: Bool = true  // restricts plant growth by energy level (if false, plants grow freely)
var sunRayIntensity: CGFloat = 3  // total energy units per sun ray per iteration
var photosynthesisRatio: CGFloat = 1  // available sun energy stored by leaf at ray contact (varies by season)
var groEnExp: CGFloat = 0.2  // growth energy expenditure rate (rate energy is expended for growth)
var livEnExp: CGFloat = 0.1  // living energy expenditure rate (rate energy is expended for living)
var energyStoreFactor: CGFloat = 1000  // a plant's maximum storable energy units per segment
    //var oldAgeMarker: Int = 20000  // age after flower bloom when plant starts dying of old age, in worldtime units
    //var oldAgeRate: CGFloat = 0.001  // additional energy reduction per iteration after plant reaches old age
var unhealthyEnergyLevelRatio: CGFloat = 0.075  // ratio of max energy when plant gets unhealthy (starts yellowing)
var minBloomEnLevRatio: CGFloat = 0  // min energy level ratio for flower to bloom
var minPollEnLevRatio: CGFloat = 0  // min energy level ratio for flower to pollinate or be pollinated
var flowerFadeEnergyLevelRatio: CGFloat = -0.025;  // ratio of maximum energy when flower begins to fade
var polinatorPadFadeEnergyLevelRatio: CGFloat = -0.075  // ratio of maximum energy when polinator pad begins to fade
var sickEnergyLevelRatio: CGFloat = -0.2  // ratio of maximum energy when plant becomes sick (starts darkening)
var podOpenEnergyLevelRatio: CGFloat = -0.3  // ratio of maximum energy when seed pod disperses seeds
var deathEnergyLevelRatio: CGFloat = -1  // ratio of maximum energy when plant dies (fully darkened)
var collapseEnergyLevelRatio: CGFloat = -2;  // ratio of maximum energy when plant collapses

//colors
var color = [
    //fills
    "hdf": [ "r": 0, "g": 100, "b": 0, "a": 1 ],  // healthy dark fill color (dark green)
    "hlf": [ "r": 0, "g": 128, "b": 0, "a": 1 ],  // healthy light fill color (green)
    "yf": [ "r": 206, "g": 171, "b": 45, "a": 1 ],  // yellowed fill color (sickly yellow)
    "df": [ "r": 94, "g": 77, "b": 21, "a": 1 ],  // dead fill color (dark brown)
    //outlines
    "hol": [ "r": 42, "g": 32, "b": 0, "a": 1 ],  // healthy outline color (very dark brown)
    "yol": [ "r": 107, "g": 90, "b": 31, "a": 1 ],  // yellowed outline color (slightly darker than leaf fill)
    "dol": [ "r": 42, "g": 32, "b": 0, "a": 1 ],  // dead outline color (very dark brown)
    //inner lines
    "hil": [ "r": 0, "g": 112, "b": 0, "a": 1 ],  // healthy inner line color (slightly darker green than leaf fill)
    "yil": [ "r": 107, "g": 90, "b": 31, "a": 1 ],  // yellowed inner line color (slightly darker than leaf fill)
    "dil": [ "r": 56, "g": 47, "b": 12, "a": 1 ],  // dead inner line color (slightly darker brown than leaf fill)
    //leaf shadows
    "hls": [ "r": 0, "g": 0, "b": 0, "a": 0.1 ],  // healthy leaf shadow color
    "yls": [ "r": 0, "g": 0, "b": 0, "a": 0.05 ],  // yellowed leaf shadow color
    "dls": [ "r": 0, "g": 0, "b": 0, "a": 0 ],  // dead leaf shadow color
    //pollen pad
    "pp": [ "r": 255, "g": 217, "b": 102, "a": 1 ],  // pollen pad color
    "pl": [ "r": 255, "g": 159, "b": 41, "a": 1 ],  // pollination line color
    "pg": [ "r": 255, "g": 98, "b": 41, "a": 1 ]  // pollen pad glow color (temporary glow when polinated)
]
