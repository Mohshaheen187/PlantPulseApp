//
//  PlantsInformation.swift
//  PlantPulseApp
//
//  Created by Mohammed Shaheen on 03.12.23.
//

import Foundation

struct PlantsInformation : Identifiable, Hashable {
    var id: Int
    var name: String
    var imageName: String
    var wateringFrequency: String
    var temperature: String
    var description: String
}

let plantsData: [PlantsInformation] = [
    PlantsInformation(id: 1, name: "Orchids", imageName: "orchids", wateringFrequency: "Weekly", temperature: "20-25°C", description: "Orchids are elegant and exotic flowers known for their diverse species. They thrive in humid conditions and bright, indirect light. Proper care involves weekly watering and maintaining a suitable temperature range."),
    
    PlantsInformation(id: 2, name: "Cactus", imageName: "cactus", wateringFrequency: "Every 2-3 weeks", temperature: "15-25°C", description: "Cacti are hardy desert plants adapted to arid environments. They store water in their thick stems, allowing them to withstand dry periods. Water sparingly, provide ample sunlight, and keep them in well-draining soil."),
    
    PlantsInformation(id: 3, name: "Rose", imageName: "rose", wateringFrequency: "Regularly, when the top inch of soil is dry", temperature: "18-24°C", description: "Roses are classic and symbolic flowers with a wide range of varieties. They require consistent watering, well-drained soil, and ample sunlight. Pruning and fertilizing contribute to healthy growth and vibrant blooms."),
    
    PlantsInformation(id: 4, name: "Fern", imageName: "fern", wateringFrequency: "Regularly to keep soil consistently moist", temperature: "18-24°C", description: "Ferns are lush, green plants with delicate fronds. They prefer high humidity and indirect light. Keep the soil consistently moist and provide a humid environment to promote optimal growth."),
    
    PlantsInformation(id: 5, name: "Sun Flower", imageName: "sun flower", wateringFrequency: "Regularly, keeping soil evenly moist", temperature: "18-27°C", description: "Sunflowers are vibrant, sun-loving plants known for their large, cheerful blooms. They thrive in full sunlight and well-drained soil. Adequate watering and support for tall stems contribute to healthy sunflower growth."),
    
    PlantsInformation(id: 6, name: "Conifers", imageName: "conifers", wateringFrequency: "Regularly, allowing soil to dry between waterings", temperature: "15-24°C", description: "Conifers are evergreen trees and shrubs with needle-like leaves. They prefer well-drained soil and are adaptable to various temperatures. Consistent watering and occasional pruning contribute to their health."),
    
    PlantsInformation(id: 7, name: "Chrysanthemum", imageName: "chrysanthemum", wateringFrequency: "Regularly, keeping soil evenly moist", temperature: "18-23°C", description: "Chrysanthemums, or mums, are colorful flowering plants popular in gardens and floral arrangements. They require regular watering, well-drained soil, and sufficient sunlight. Pruning helps maintain a bushy and compact shape."),
    
    PlantsInformation(id: 8, name: "Lily", imageName: "lily", wateringFrequency: "Regularly, keeping soil consistently moist", temperature: "18-24°C", description: "Lilies are elegant, fragrant flowers with various varieties. They prefer consistently moist soil and well-drained conditions. Adequate sunlight and proper spacing contribute to healthy lily plants."),
    
    PlantsInformation(id: 9, name: "Aster", imageName: "aster", wateringFrequency: "Regularly, keeping soil evenly moist", temperature: "15-24°C", description: "Asters are daisy-like flowers available in a range of colors. They thrive in well-drained soil and require regular watering. Adequate sunlight and deadheading spent blooms promote continuous flowering."),
    
    PlantsInformation(id: 10, name: "Snake Plant", imageName: "snake plant", wateringFrequency: "Every 2-3 weeks", temperature: "15-27°C", description: "Snake plants, or Sansevieria, are hardy and low-maintenance. They tolerate low light conditions and infrequent watering. Well-drained soil and moderate temperatures contribute to the resilience of snake plants."),
    
    PlantsInformation(id: 11, name: "Narcissus", imageName: "narcissus", wateringFrequency: "Regularly during active growth, allowing soil to dry between waterings", temperature: "15-20°C", description: "Narcissus, including daffodils, are spring-blooming bulbs known for their trumpet-shaped flowers. They prefer well-drained soil and moderate temperatures. Adequate sunlight and proper care after blooming ensure repeat flowering in the following seasons.")
]
