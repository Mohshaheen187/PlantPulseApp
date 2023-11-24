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
    
    var body: some View {
        NavigationView {
            ZStack {
                List {
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
                            }
                        }
                    }
                    .onDelete(perform: deletePlant)
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
                            AddNewPlantView(isPlantAdded: $isPlantAdded)
                                .presentationDragIndicator(.visible)
                                .presentationDetents([.fraction(0.5)])
                        })
                    }
                    
                    ToolbarItem(placement: .topBarLeading) {
                        EditButton()
                    }
                }
                
                //                if isPlantAdded {
                //                    VStack {
                //                        LottieView(lottieFile: "done")
                //                            .frame(width: 100, height: 100)
                //
                //                        Text("Your plant has been added successfully!")
                //                            .transition(.slide)
                //                    }
                //                    .onAppear {
                //                        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                //                            withAnimation {
                //                                isPlantAdded = false
                //                            }
                //                        }
                //                    }
                //                }
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
