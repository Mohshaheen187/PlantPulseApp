//
//  ContentView.swift
//  PlantPulseApp
//
//  Created by Mohammed Shaheen on 21.11.23.
//

import SwiftUI

struct MainView: View {
    
    @State private var addPlant: Bool = false
    @State private var selectedIndex: Int = 1
    
    @EnvironmentObject var manager: DataManager
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(sortDescriptors: []) private var plants: FetchedResults<Plant>
    
    var body: some View {
        NavigationView {
            List {
                ForEach(plants) { plant in
                    NavigationLink {
                        PlantDetailsView(plants: plant)
                    } label: {
                        HStack {
                            Image((plant.plantImage != nil) ? plant.plantImage! : "questionmark.circle.fill")
                                .resizable()
                                .frame(width: 70, height: 70)
                                .clipShape(Circle())
                            Text(plant.plantType!.capitalized)
                                .font(.system(size: 20, weight: .medium, design: .rounded))
                        }
                    }
                    .tag(plant.id)
                }
            }
            .navigationTitle("Plants")
            .listStyle(.inset)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button(action: {
                        addPlant = true
                    }, label: {
                        Image(systemName: "plus.circle.fill")
                    })
                    .sheet(isPresented: $addPlant, content: {
                        AddNewPlantView()
                            .presentationDragIndicator(.visible)
                            .presentationDetents([.fraction(0.5)])
                    })
                }
            }
        }
    }
}


#Preview {
    MainView()
}
