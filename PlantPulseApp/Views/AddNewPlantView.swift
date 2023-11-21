//
//  AddNewPlantView.swift
//  PlantPulseApp
//
//  Created by Mohammed Shaheen on 21.11.23.
//

import SwiftUI
import PhotosUI

struct AddNewPlantView: View {
    
    @State private var plantType : String = ""
    @State private var selectedPlantType : Plants = .aster
    @State private var selectedPlantImage : String = ""
    @State private var creationDate : Date = Date.now
    
    @Environment (\.dismiss) var dismiss
    @Environment (\.managedObjectContext) var moc
    
    var body: some View {
        NavigationStack {
            List {
                Picker("Select plant type", selection: $selectedPlantType) {
                    ForEach(Plants.allCases.sorted(by: { $0.rawValue < $1.rawValue}), id: \.self) { type in
                        HStack {
                            Image(type.plantImage)
                                .resizable()
                                .frame(width: 40, height: 40)
                            Text(type.plantType)
                                .tag(type)
                        }
                        .onTapGesture {
                            selectedPlantImage = type.plantImage
                        }
                    }
                }
                .pickerStyle(.navigationLink)
                
                DatePicker("Date planted/bought", selection: $creationDate, in: ...Date.now, displayedComponents: .date)
            }
            .padding()
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
                    Button(action: {
                        DataManager().addPlant(plantType: selectedPlantType.rawValue, date: creationDate, image: selectedPlantImage, context: moc)
                        print("Added")
                        dismiss()
                    }, label: {
                        Text("Add")
                            .bold()
                    })
                }
            }
        }
    }
}

#Preview {
    AddNewPlantView()
}
