//
//  EvolutionEngine.swift
//  Kiss The Sky
//
//  Adapted from Evolve.js by Matthew Main on 6/1/19.
//  Copyright © 2019 Matthew Main. All rights reserved.
//

import SpriteKit



////////////////// EVOLUTION ENGINE //////////////////

class EvolutionEngine {
    
    //species collection (a collection of genome objects by species name)
    var species: [String:Genome] = [:]  // as ["<speciesName>":<genomeInstance>]
    
    //genotype type classifications
    enum ReproductionType { case asexual, autogamous, sexual }
    enum DominanceType { case complete, co, partial }
    enum ExpressionType { case count, scale }
    enum Sex { case none, hermaphrodite, male, female }
    
    
    //// Structures & Classes ////
    
    //allele (a trait; e.g., brown eyes)
    class Allele {
        var value: CGFloat
        var dominanceIndex: CGFloat
        init(value: CGFloat, dominanceIndex: CGFloat ) {
            self.value = value
            self.dominanceIndex = dominanceIndex
        }
    }
    
    //mutation parameters
    struct MutationParameters {
        let frequency: Int
        let range: CGFloat
        let min: CGFloat?
        let max: CGFloat?
        init(frequency: Int, range: CGFloat, min: CGFloat, max: CGFloat) {
            self.frequency = frequency
            self.range = range
            self.min = min
            self.max = max
        }
    }

    //gene locus (a feature; e.g. eye color)
    struct Gene {
        let allele1: Allele
        let allele2: Allele
        let dominanceType: DominanceType
        let expressionType: ExpressionType
        let mutationParameters: MutationParameters
        init(allele1: Allele, allele2: Allele, dominanceType: DominanceType, expressionType: ExpressionType, mutationParameters: MutationParameters) {
            self.allele1 = allele1
            self.allele2 = allele2
            self.dominanceType = dominanceType
            self.expressionType = expressionType
            self.mutationParameters = mutationParameters
        }
    }
        
    //genome (all of a species' genes; i.e., a blueprint for a generic body)
    class Genome {
        let reproductionType: ReproductionType
        init(reproductionType: ReproductionType) {
            self.reproductionType = reproductionType
        }
        var genes: [String:Gene] = [:] // (as ["<geneName>": <geneInstance>])
    }

    //genotype (all of an organism's allele pairs; i.e., a blueprint for a specific body**)
    struct Genotype {
        var genes: [String:Gene] = [:] // (as ["<geneName>": <geneInstance>])
        var reproductionType: ReproductionType
        init (genome: Genome ) {
            for (geneName, gene) in genome.genes {
                self.genes[geneName] = gene
            }
            self.reproductionType = genome.reproductionType
        }
    }

    //phenotype (all of an organism's expressed traits; i.e., a body)
    struct Phenotype {
        var genes: [String:Any] = [:]  // (as ["<traitNameValue>": <value>])
        let sex: Sex
        init(genotype: Genotype) {
            for (geneName, gene) in genotype.genes {
                if gene.dominanceType == .complete {  // expresses dominant allele value only (1,2 -> 2)
                    let dominanceDifference = gene.allele1.dominanceIndex - gene.allele2.dominanceIndex
                    self.genes["\(geneName)Value"] = dominanceDifference >= 0 ? gene.allele1.value : gene.allele2.value
                } else if gene.dominanceType == .partial {  // expresses average of allele values (1,2 -> 1.5)
                    self.genes["\(geneName)Value"] = (gene.allele1.value + gene.allele2.value)/2
                } else if gene.dominanceType == .co {  // expresses combination of allele values (1,2 -> [1,2])
                    self.genes["\(geneName)Value"] = [ gene.allele1.value, gene.allele2.value ]
                }
            }
            switch genotype.reproductionType {
                case .asexual: self.sex = .none
                case .autogamous: self.sex = .hermaphrodite
                case .sexual: self.sex = Int.random(in: 1...2) == 1 ? .female : .male
            }
        }
    }


    //// Methods ////

    //adds a new species genome to the collection of species objects
    func addGenome(speciesName: String, reproductionType: ReproductionType ) -> Genome {
        species[speciesName] = Genome(reproductionType: reproductionType)
        return species[speciesName]!
    }

    //adds a new gene (with identical prototype alleles of neutral dominance) to a species genome
    func addGene(genome: Genome,
                 geneName: String,
                 domType: DominanceType,
                 expType: ExpressionType,
                 initVal: CGFloat,
                 mutationParameters: MutationParameters ) -> Gene {
        let gene = Gene(allele1: Allele(value: initVal, dominanceIndex: 0.5 ),
                        allele2: Allele(value: initVal, dominanceIndex: 0.5 ),
                        dominanceType: domType,
                        expressionType: expType,
                        mutationParameters: mutationParameters)
        genome.genes[geneName] = gene
        return gene
    }

    //creates a new standard genotype from a species genome (for genetically identical organisms)
    func newStandardFirstGenGenotype(genome: Genome) -> Genotype {
        return Genotype(genome: genome)
    }

    //creates a new random genotype from a species genome (for genetically distinct organisms)
    func newRandomizedFirstGenGenotype(genome: Genome ) -> Genotype{
        var randomizedGenotype = Genotype(genome: genome)
        for (geneName,gene) in genome.genes {
            var newAllele1 = randomizedGenotype.genes[geneName]!.allele1
            var newAllele2 = randomizedGenotype.genes[geneName]!.allele2
            newAllele1 = mutate(genome: genome, gene: gene, allele: newAllele1)
            newAllele2 = mutate(genome: genome, gene: gene, allele: newAllele2)
        }
        return randomizedGenotype
    }

    //generates a phenotype from a genotype
    func generatePhenotype(genotype: Genotype) -> Phenotype {
        return Phenotype(genotype: genotype)
    }

    //mutates an allele (changes its value according to its expression type and within its mutation range)
    func mutate(genome: Genome, gene: Gene, allele: Allele ) -> Allele {
        let range: CGFloat = gene.mutationParameters.range  // range (of a single mutation)
        let min: CGFloat? = gene.mutationParameters.min  // min value (mutation cannot go below)
        let max: CGFloat? = gene.mutationParameters.max  // max value (mutation cannot go above)
        let originalAlleleVal: CGFloat = allele.value
        var mutatedAlleleVal: CGFloat = CGFloat.random(in: allele.value-range/2...allele.value+range/2)  // random decimal value in mutation range
        if gene.expressionType == .count {
            mutatedAlleleVal = mutatedAlleleVal.rounded()  // (rounds to integer for "count" expression type)
        }
        if ( ( min == nil || mutatedAlleleVal >= min!) && ( max == nil || mutatedAlleleVal <= max!) ) {
            allele.value = mutatedAlleleVal  // (mutates allele value if within min and max value parameters)
        }
        if ( allele.value != originalAlleleVal ) {
            allele.dominanceIndex = CGFloat.random(in: 0...1)  // (assigns new random dominance index if allele has mutated)
        }
        return allele
    }

    //performs meiosis (returns a new child genotype from a parent genotype or genotypes)
    func meiosis(genome: Genome, parentGenotype1: Genotype, parentGenotype2: Genotype? = nil ) -> Genotype{
        var parentGenotype2 = parentGenotype2
        if (parentGenotype2 == nil ) { parentGenotype2 = parentGenotype1 }
        var childGenotype = Genotype(genome: genome)
        for (geneName,gene) in genome.genes {
            let parent1Allele = Int.random(in: 1...2) == 1 ? parentGenotype1.genes[geneName]!.allele1 : parentGenotype1.genes[geneName]!.allele2
            let parent2Allele = Int.random(in: 1...2) == 1 ? parentGenotype2!.genes[geneName]!.allele1 : parentGenotype2!.genes[geneName]!.allele2
            var newAllele1 = Allele(value: parent1Allele.value, dominanceIndex: parent1Allele.dominanceIndex)
            var newAllele2 = Allele(value: parent2Allele.value, dominanceIndex: parent2Allele.dominanceIndex)
            if ( Int.random(in: 1...gene.mutationParameters.frequency) == 1 ) {
                if ( Int.random(in: 1...2) == 1 ) {
                    newAllele1 = mutate(genome: genome, gene: gene, allele: newAllele1)
                } else {
                    newAllele2 = mutate(genome: genome, gene: gene, allele: newAllele2)
                }
            }
            childGenotype.genes[geneName] = Gene(allele1: newAllele1, allele2: newAllele2, dominanceType: gene.dominanceType, expressionType: gene.expressionType, mutationParameters: gene.mutationParameters)
        }
        return childGenotype
    }

}








/////-- Notes --/////

//*frequency as average meiosis events per mutation; higher is less frequent
//**in this model, an entire genotype is contained on a single autosome






