//
//  DataManager.swift
//  PlantPulseApp
//
//  Created by Mohammed Shaheen on 21.11.23.
//

import Foundation
import CoreData

class DataManager : ObservableObject {
    let container : NSPersistentContainer = NSPersistentContainer(name: "PlantsModel")
    
    init() {
        container.loadPersistentStores() { desc, error in
            if let error = error {
                print("Failure message : \(error.localizedDescription)")
            }
        }
    }
    
    func saveNewPlant(context: NSManagedObjectContext) {
        do {
            try context.save()
            print("Plant saved!")
        } catch {
            print("Failed to save!")
        }
    }
    
    func addPlant(plantType: String, date: Date, image: String, context: NSManagedObjectContext) {
        let newPlant = Plant(context: context)
        
        newPlant.id = UUID()
        newPlant.plantType = plantType
        newPlant.date = date
        newPlant.plantImage = image
        
        saveNewPlant(context: context)
    }
    
    func deletePlant(plant: Plant, context: NSManagedObjectContext) {
        context.delete(plant)
        saveNewPlant(context: context)
    }
}
