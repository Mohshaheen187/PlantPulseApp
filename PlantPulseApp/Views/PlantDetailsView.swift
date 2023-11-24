//
//  PlantDetailsView.swift
//  PlantPulseApp
//
//  Created by Mohammed Shaheen on 21.11.23.
//

import SwiftUI

struct PlantDetailsView: View {
    
    var plants : FetchedResults<Plant>.Element
    
    @State private var isWatering : Bool = false // If FALSE, it's not watering
    @State private var isFinished : Bool = false
    @State private var progress : Double = 0.0
    let timer = Timer.publish(every: 1.0, on: .main, in: .common).autoconnect()
    
    var body: some View {
        VStack(spacing: 10) {
            Image(plants.plantImage ?? "question")
                .resizable()
                .clipShape(Circle())
                .frame(width: 200, height: 200)
            Text(plants.plantType!.capitalized)
                .font(.system(size: 30, weight: .medium, design: .rounded))
            
            if let lastDateWatered = plants.lastDateWatered {
                Text("Last time watered: \(lastDateWatered.formatted(.dateTime.day().month().year().hour().minute()))")
            } else {
                Text("Last time watered: Never watered")
            }
            
            Spacer()
            
            Button(isWatering ? "Finish" : "Start") {
                withAnimation {
                    if !isWatering {
                        progress += 1.0
                        isFinished = false
                    }
                    isWatering.toggle()
                    isFinished = true
                }
            }
            .foregroundStyle(.white)
            .bold()
            .frame(width: 130, height: 130)
            .background(.linearGradient(colors: [.blue, .purple], startPoint: .bottomLeading, endPoint: .topTrailing))
            .clipShape(Circle())
            
            VStack {
                Text("Irrigation rate: \(String(format: "%.0f", progress))%")
                ProgressView(value: progress, total: 100)
                    .onReceive(timer) { _ in
                        if isWatering && progress < 100 {
                            progress += 1.0
                        }
                        
                        if isFinished {
                            plants.lastDateWatered = Date()
                            do {
                                try plants.managedObjectContext?.save()
                            } catch {
                                print("Failure Message: \(error)")
                            }
                        }
                    }
            }
            
            Spacer()
        }
        .navigationTitle("Date planted: \(plants.date!.formatted(.dateTime.day().month().year()))")
        .navigationBarTitleDisplayMode(.inline)
        .padding()
    }
}
