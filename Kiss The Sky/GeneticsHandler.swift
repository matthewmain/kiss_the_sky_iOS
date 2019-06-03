//
//  GeneticsHandler.swift
//  Kiss The Sky
//
//  Created by Matthew Main on 6/1/19.
//  Copyright © 2019 Matthew Main. All rights reserved.
//

import CoreGraphics



////////////////// GENETICS HANDLER //////////////////


var EV = EvolutionEngine()
var skyPlantGenome = EV.addGenome(speciesName: "skyPlant", reproductionType: .autogamous )


func createSkyPlantGenes() {
    EV.addGene(genome: skyPlantGenome, geneName: "maxTotalSegments", domType: .complete, expType: .count, initValue: 8, mutationFrequency: 5, mutationRange: 6, mutationMinValue: 2, mutationMaxValue: nil)
    EV.addGene(genome: skyPlantGenome, geneName: "maxSegmentWidth", domType: .partial, expType: .scale, initValue: 8, mutationFrequency: 5, mutationRange: 4, mutationMinValue: 8, mutationMaxValue: nil)
    EV.addGene(genome: skyPlantGenome, geneName: "stalkStrength", domType: .partial, expType: .scale, initValue: 0.8, mutationFrequency: 5, mutationRange: 0.1, mutationMinValue: 0.7, mutationMaxValue: 0.8)
    EV.addGene(genome: skyPlantGenome, geneName: "firstLeafSegment", domType: .complete, expType: .count, initValue: 3, mutationFrequency: 5, mutationRange: 4, mutationMinValue: 2, mutationMaxValue: nil)
    EV.addGene(genome: skyPlantGenome, geneName: "leafFrequency", domType: .complete, expType: .count, initValue: 2, mutationFrequency: 5, mutationRange: 2, mutationMinValue: 2, mutationMaxValue: nil)
    EV.addGene(genome: skyPlantGenome, geneName: "maxLeafLength", domType: .partial, expType: .scale, initValue: 5.5, mutationFrequency: 5, mutationRange: 3, mutationMinValue: 4, mutationMaxValue: nil)
    EV.addGene(genome: skyPlantGenome, geneName: "flowerHue", domType: .complete, expType: .count, initValue: 130, mutationFrequency: 5, mutationRange: 50, mutationMinValue: 0, mutationMaxValue: 260)
    EV.addGene(genome: skyPlantGenome, geneName: "flowerLightness", domType: .complete, expType: .count, initValue: 55, mutationFrequency: 5, mutationRange: 30, mutationMinValue: 30, mutationMaxValue: 75)
}


func assignRandomFlowerColor(genotype: EvolutionEngine.Genotype) {
    for (geneName,gene) in genotype.genes {
        if geneName == "flowerHue" {
            gene.allele1.value = randcgfR(0,260)
            gene.allele2.value = randcgfR(0,260)
        } else if geneName == "flowerLightness" {
            gene.allele1.value = randcgfR(30,75)
            gene.allele2.value = randcgfR(30,75)
        }
    }
}



///// Custom First-Generation Genotype Generators /////


func generateRandomPlantGenotype() -> EvolutionEngine.Genotype {
    let newGenotype = EV.newRandomizedFirstGenGenotype(genome: skyPlantGenome)
    assignRandomFlowerColor(genotype: newGenotype)
    return newGenotype
}


func generateRandomRedFlowerPlantGenotype() -> EvolutionEngine.Genotype {
    var newGenotype = EV.newRandomizedFirstGenGenotype(genome: skyPlantGenome)
    newGenotype.genes["flowerHue"]?.allele1.value = Int.random(in: 1...2) == 1 ? randcgfR(0,5) : randcgfR(255,260)
    newGenotype.genes["flowerHue"]?.allele2.value = Int.random(in: 1...2) == 1 ? randcgfR(0,5) : randcgfR(255,260)
    newGenotype.genes["flowerLightness"]?.allele1.value = randcgfR(30,75)
    newGenotype.genes["flowerLightness"]?.allele2.value = randcgfR(30,75)
    return newGenotype
}


func generateTinyWhiteFlowerPlantGenotype() -> EvolutionEngine.Genotype {
    let newGenotype = EV.newRandomizedFirstGenGenotype(genome: skyPlantGenome )
    newGenotype.genes["maxTotalSegments"]?.allele1.value = 2
    newGenotype.genes["maxTotalSegments"]?.allele2.value = 2
    newGenotype.genes["maxSegmentWidth"]?.allele1.value = 8
    newGenotype.genes["maxSegmentWidth"]?.allele2.value = 8
    newGenotype.genes["firstLeafSegment"]?.allele1.value = 2
    newGenotype.genes["firstLeafSegment"]?.allele2.value = 2
    newGenotype.genes["leafFrequency"]?.allele1.value = 2
    newGenotype.genes["leafFrequency"]?.allele2.value = 2
    newGenotype.genes["maxLeafLength"]?.allele1.value = 4
    newGenotype.genes["maxLeafLength"]?.allele2.value = 4
    newGenotype.genes["flowerHue"]?.allele1.value = randcgfR(0,260)
    newGenotype.genes["flowerHue"]?.allele2.value = randcgfR(0,260)
    newGenotype.genes["flowerLightness"]?.allele1.value = 75
    newGenotype.genes["flowerLightness"]?.allele2.value = 75
    return newGenotype
}



///// DEVELOPMENT /////


func generateTallPlantGenotype() -> EvolutionEngine.Genotype {
    var newGenotype = EV.newRandomizedFirstGenGenotype(genome: skyPlantGenome)
    newGenotype.genes["maxTotalSegments"]?.allele1.value = 25
    newGenotype.genes["maxTotalSegments"]?.allele2.value = 25
    newGenotype.genes["maxSegmentWidth"]?.allele1.value = 10
    newGenotype.genes["maxSegmentWidth"]?.allele2.value = 10
    newGenotype.genes["stalkStrength"]?.allele1.value = 1
    newGenotype.genes["stalkStrength"]?.allele2.value = 1
    newGenotype.genes["maxLeafLength"]?.allele1.value = 5
    newGenotype.genes["maxLeafLength"]?.allele2.value = 5
    assignRandomFlowerColor(genotype: newGenotype)
    return newGenotype
}


func generateHugeRedPlantGenotype() -> EvolutionEngine.Genotype {
    var newGenotype = EV.newRandomizedFirstGenGenotype(genome: skyPlantGenome)
    newGenotype.genes["maxTotalSegments"]?.allele1.value = 11
    newGenotype.genes["maxTotalSegments"]?.allele2.value = 11
    newGenotype.genes["maxSegmentWidth"]?.allele1.value = 30
    newGenotype.genes["maxSegmentWidth"]?.allele2.value = 30
    newGenotype.genes["maxLeafLength"]?.allele1.value = 9
    newGenotype.genes["maxLeafLength"]?.allele2.value = 9
    newGenotype.genes["flowerHue"]?.allele1.value = 0
    newGenotype.genes["flowerHue"]?.allele2.value = 0
    newGenotype.genes["flowerLightness"]?.allele1.value = 35
    newGenotype.genes["flowerLightness"]?.allele2.value = 35
    return newGenotype
}

