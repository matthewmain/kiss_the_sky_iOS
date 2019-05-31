//
//  Trackers.swift
//  Kiss The Sky
//
//  Created by Matthew Main on 5/31/19.
//  Copyright © 2019 Matthew Main. All rights reserved.
//

import SpriteKit



////////////////// TRACKERS //////////////////


//var initialGeneValueAverages: [Gene: CGFloat] = [:]
var gameHasBegun: Bool = false  // whether user has initiated game play
var gamePaused: Bool = false  // whether game is paused
var highestRedFlowerPct: CGFloat = 0
var readyForEliminationDemo: Bool = false  // whether first year and spring announcement has completed
var readyForChangeDemo: Bool = false  // whether first year and summer announcement has completed
var eliminationDemoHasBegun: Bool = false  // whether instructional elimination demo has begun running
var changeDemoHasBegun: Bool = false  // whether instructional mutation/recessive trait demo has begun running
var allDemosHaveRun: Bool = false
var gameHasEnded: Bool = false
var endOfGameAnnouncementDisplayed: Bool = false
var gameOverDisplayed: Bool = false
var gameWinFlowerAnimationDisplayed: Bool = false
var stopGameWinFlowersAnimation: Bool = false
var gameWinFlowerAnimationComplete: Bool = false
