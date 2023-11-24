//
//  AddNewPlantView.swift
//  PlantPulseApp
//
//  Created by Mohammed Shaheen on 21.11.23.
//

import SwiftUI
import CoreData

struct AddNewPlantView: View {
    
    @State private var plantType : String = ""
    @State private var selectedPlantType : Plants = .aster
    @State private var selectedPlantImage : String = ""
    @State private var creationDate : Date = Date.now
    @Binding var isPlantAdded : Bool
    
    @Environment (\.dismiss) var dismiss
    @Environment (\.managedObjectContext) var moc
    
    var body: some View {
        NavigationStack {
            List {
                Picker("Select plant type", selection: $selectedPlantType) {
                    ForEach(Plants.allCases.sorted(by: { $0.rawValue < $1.rawValue}), id: \.self) { plant in
                        Label(
                            title: {
                                Text(plant.plantType)
                            }, icon: {
                                Image(plant.plantImage)
                                    .resizable()
                                    .frame(width: 40, height: 40)
                                    .clipShape(Circle())
                            }
                        )
                        .task {
                            selectedPlantImage = plant.plantImage
                        }
                    }
                }
                .pickerStyle(.navigationLink)
                
                DatePicker("Date planted/bought", selection: $creationDate, in: ...Date.now, displayedComponents: .date)
            }
            .listStyle(.inset)
            .navigationTitle("Add new plant")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button(action: {
                        dismiss()
                    }, label: {
                        Image(systemName: "xmark")
                    })
                }
                
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Add") {
                        withAnimation {
                            DataManager().addPlant(plantType: selectedPlantType.rawValue, date: creationDate, plantImage: selectedPlantImage, context: moc)
                            isPlantAdded = true
                            dismiss()
                        }
                    }
                    .bold()
                }
            }
        }
    }
}

#Preview {
    AddNewPlantView(isPlantAdded: .constant(false))
}
