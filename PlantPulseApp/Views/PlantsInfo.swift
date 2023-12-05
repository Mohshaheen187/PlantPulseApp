//
//  PlantsInfo.swift
//  PlantPulseApp
//
//  Created by Mohammed Shaheen on 03.12.23.
//

import SwiftUI

struct PlantsInfo: View {
    
    private let adaptiveColumns = [
        GridItem(.adaptive(minimum: 150))
    ]
    
    var body: some View {
        NavigationStack {
            ScrollView {
                LazyVGrid(columns: adaptiveColumns, spacing: 40) {
                    ForEach(plantsData, id: \.self) { plant in
                        NavigationLink {
                            plantInfoDetails(plant: plant)
                                .navigationBarBackButtonHidden(true)
                        } label: {
                            RoundedRectangle(cornerRadius: 10.0)
                                .fill(.white)
                                .frame(width: 170, height: 170)
                                .shadow(radius: 10)
                                .overlay {
                                    VStack {
                                        Image(plant.imageName)
                                            .resizable()
                                            .aspectRatio(contentMode: .fill)
                                            .clipShape(Circle())
                                            .frame(width: 70, height: 70)
                                        Text(plant.name)
                                    }
                                }
                        }
                    }
                }
                .padding()
            }
            .navigationTitle("Plants")
        }
        .tint(.black)
        .font(.custom("Next Sunday", size: 17))
    }
}


struct plantInfoDetails : View {
    
    @Environment (\.dismiss) var dismiss
    
    var plant : PlantsInformation
    
    var body: some View {
        VStack(alignment: .leading) {
            Image(plant.imageName)
                .resizable()
                .frame(maxWidth: .infinity)
                .frame(height: 260)
            
            HStack(alignment: .top) {
                
                HStack(alignment: .top) {
                    Image(systemName: "drop.fill")
                        .foregroundStyle(.blue)
                    VStack(alignment: .leading, spacing: 9) {
                        Text("Watering frequency:")
                        Text(plant.wateringFrequency)
                            .font(.system(size: 14, weight: .medium, design: .rounded))
                    }
                }
                
                Spacer()
                
                HStack(alignment: .top) {
                    Image(systemName: "thermometer.medium")
                        .foregroundStyle(.red)
                    VStack(alignment: .leading, spacing: 9) {
                        Text("Temperature:")
                        Text(plant.temperature)
                            .font(.system(size: 14, weight: .medium, design: .rounded))
                    }
                }
            }
            .padding()
            
            VStack(alignment: .leading, spacing: 10) {
                Text("What do you know about \(plant.name)?")
                    .font(.custom("Next Sunday", size: 15))
                    .foregroundStyle(.secondary)
                Text(plant.description)
                    .font(.custom("Next Sunday", size: 17))
                    .fixedSize(horizontal: false, vertical: true)
            }
            .padding()
            
            Spacer()
        }
        .navigationTitle(plant.name)
        .toolbar {
            ToolbarItem(placement: .bottomBar) {
                Button("Back") {
                    dismiss()
                }
                .padding(10)
                .foregroundStyle(.white)
                .bold()
                .background(.green)
                .clipShape(RoundedRectangle(cornerRadius: 20))
            }
        }
    }
}


#Preview {
    PlantsInfo()
}
