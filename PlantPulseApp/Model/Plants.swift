//
//  Plants.swift
//  PlantPulseApp
//
//  Created by Mohammed Shaheen on 21.11.23.
//

import Foundation

enum Plants: String, CaseIterable {
    case orchids
    case cactus
    case rose
    case fern
    case sunFlower
    case conifers
    case chrysanthemum
    case lily
    case aster
    case snakePlant
    case narcissus
    
    var plantType : String {
        switch self {
        case .orchids:
            return "Orchids"
        case .cactus:
            return "Cactus"
        case .rose:
            return "Rose"
        case .fern:
            return "Fern"
        case .sunFlower:
            return "Sun Flower"
        case .conifers:
            return "Conifers"
        case .chrysanthemum:
            return "Chrysanthemum"
        case .lily:
            return "Lily"
        case .aster:
            return "Aster"
        case .snakePlant:
            return "Snake Plant"
        case .narcissus:
            return "Narcisuss"
        }
    }
    
    var plantImage : String {
        switch self {
        case .orchids:
            return "orchids"
        case .cactus:
            return "cactus"
        case .rose:
            return "rose"
        case .fern:
            return "fern"
        case .sunFlower:
            return "sun flower"
        case .conifers:
            return "conifers"
        case .chrysanthemum:
            return "chrysanthemum"
        case .lily:
            return "lily"
        case .aster:
            return "aster"
        case .snakePlant:
            return "snake plant"
        case .narcissus:
            return "narcissus"
        }
    }
}
