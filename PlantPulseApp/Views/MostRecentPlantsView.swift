//
//  MostRecentPlantsView.swift
//  PlantPulseApp
//
//  Created by Mohammed Shaheen on 29.11.23.
//

import SwiftUI

struct MostRecentPlantsView: View {
    
    @EnvironmentObject var manager: DataManager
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(sortDescriptors: [SortDescriptor(\.date, order: .reverse)]) var plants: FetchedResults<Plant>
    
    var body: some View {
        ForEach(plants.prefix(3)) { plant in
            HStack {
                Image(plant.plantImage ?? "camera.macro")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .clipShape(Circle())
                    .frame(width: 100, height: 100)
                    .padding()
                
                VStack(alignment: .leading) {
                    Text(plant.plantType?.capitalized ?? "Unknown plant type")
                        .font(.system(size: 25, weight: .medium, design: .rounded))
                    Text(calcTimeSince(date: plant.date!))
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                }
                
                Spacer()
            }
            .tag(plant)
            .frame(width: 330, height: 150)
            .padding()
            .background(
                RoundedRectangle(cornerRadius: 25.0)
                    .fill(.white)
                    .padding()
                    .shadow(radius: 10)
            )
        }
    }
}

#Preview {
    MostRecentPlantsView()
}
