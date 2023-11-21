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
            TabView(selection: $selectedIndex) {
                ForEach(plants) { plant in
                    NavigationLink {
                        PlantDetailsView(plants: plant)
                    } label: {
                        RoundedRectangle(cornerRadius: 20.0)
                            .fill(Color.white)
                            .shadow(radius: 10)
                            .overlay {
                                VStack {
                                    Image((plant.plantImage != nil) ? plant.plantImage! : "xmark")
                                        .resizable()
                                        .frame(width: 150, height: 150)
                                        .clipShape(Circle())
                                    Text(plant.plantType!.capitalized)
                                        .font(.system(size: 30, weight: .medium, design: .rounded))
                                        
                                    if let date = plant.date {
                                        Text("Date planted: \(date.formatted(.dateTime.day().month().year()))")
                                    }
                                }
                                .padding()
                            }
                            .frame(height: 400)
                            .padding()
                    }
                    .tag(plant.id)
                    .contextMenu {
                        Button("Delete", role: .destructive) {
                            DataManager().deletePlant(plant: plant, context: viewContext)
                        }
                        
                        Button("Edit") {
                            
                        }
                    }
                }
            }
            .tabViewStyle(.page(indexDisplayMode: .never))
            .indexViewStyle(.page(backgroundDisplayMode: .always))
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
