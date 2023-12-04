//
//  ContentView.swift
//  PlantPulseApp
//
//  Created by Mohammed Shaheen on 21.11.23.
//

import SwiftUI
import Lottie

struct MainView: View {
    
    @State private var addPlant: Bool = false
    @State private var selectedIndex: Int = 1
    @State private var isPlantAdded : Bool = false
    
    @EnvironmentObject var manager: DataManager
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(sortDescriptors: [SortDescriptor(\.date, order: .reverse)]) var plants: FetchedResults<Plant>
    
    @Environment (\.dismiss) var dismiss
    
    var body: some View {
        NavigationStack {
            ZStack {
                List {
                    Section {
                        TabView(selection: $selectedIndex) {
                            if plants.isEmpty {
                                Text("You don't have any plants")
                                    .font(.system(size: 25, weight: .medium, design: .rounded))
                                    .foregroundStyle(.secondary)
                                    .frame(alignment: .center)
                                    .indexViewStyle(.page(backgroundDisplayMode: .never))
                            } else {
                                MostRecentPlantsView()
                            }
                        }
                        .tabViewStyle(.page(indexDisplayMode: .always))
                        .indexViewStyle(.page(backgroundDisplayMode: .always))
                        .frame(idealHeight: 250)
                    } header: {
                        Text("Most recent plants")
                    }
                    
                    Section {
                        ForEach(plants) { plant in
                            NavigationLink {
                                PlantDetailsView(plants: plant)
                            } label: {
                                HStack {
                                    Image(plant.plantImage ?? "question")
                                        .resizable()
                                        .frame(width: 70, height: 70)
                                        .clipShape(Circle())
                                    Text((plant.plantType != nil) ? plant.plantType! : "Unknown Plant Type")
                                        .font(.system(size: 20, weight: .medium, design: .rounded))
                                    Spacer()
                                    Text(calcTimeSince(date: plant.date!))
                                        .font(.subheadline)
                                        .foregroundStyle(.secondary)
                                }
                            }
                        }
                        .onDelete(perform: deletePlant)
                    } header: {
                        Text("My plants")
                    }
                    .navigationTitle("Plants")
                    .listStyle(.inset)
                }
                .listStyle(.inset)
                
                if isPlantAdded {
                    LottieView(lottieFile: "done")
                        .onAppear {
                            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                                withAnimation {
                                    isPlantAdded = false
                                }
                            }
                        }
                }
            }
            .navigationTitle("Dashboard")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button(action: {
                        addPlant = true
                    }, label: {
                        Image(systemName: "plus.circle.fill")
                    })
                    .sheet(isPresented: $addPlant, content: {
                        AddNewPlantView(isPlantAdded: $isPlantAdded)
                            .presentationDragIndicator(.visible)
                            .presentationDetents([.fraction(0.5)])
                    })
                }
                
                ToolbarItem(placement: .topBarLeading) {
                    EditButton()
                }
            }
        }
    }
    
    private func deletePlant(offsets: IndexSet) {
        withAnimation {
            offsets.map { plants[$0] }.forEach(viewContext.delete)
            DataManager().saveNewPlant(context: viewContext)
        }
    }
}


#Preview {
    MainView()
}
