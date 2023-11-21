//
//  PlantDetailsView.swift
//  PlantPulseApp
//
//  Created by Mohammed Shaheen on 21.11.23.
//

import SwiftUI

struct PlantDetailsView: View {
    
    var plants : FetchedResults<Plant>.Element
    
    @State private var isWatering : Bool = false
    @State private var progress : Double = 0.0
    let timer = Timer.publish(every: 1.0, on: .main, in: .common).autoconnect()
    
    var body: some View {
        VStack(spacing: 10) {
            Image((plants.plantImage != nil) ? plants.plantImage! : "questionmark.circle.fill")
                .resizable()
                .clipShape(Circle())
                .frame(width: 200, height: 200)
            Text(plants.plantType!.capitalized)
                .font(.system(size: 30, weight: .medium, design: .rounded))
            
            Text("Last time watered: ")
            
            Spacer()
            
            Button(isWatering ? "Finish" : "Start") {
                withAnimation {
                    if !isWatering {
                        progress += 1.0
                    }
                    isWatering.toggle()
                }
            }
            .foregroundStyle(.white)
            .bold()
            .frame(width: 100, height: 100)
            .background(.linearGradient(colors: [.blue, .purple], startPoint: .bottomLeading, endPoint: .topTrailing))
            .clipShape(Circle())
            
            VStack {
                Text("Irrigation rate: \(String(format: "%.0f", progress))%")
                ProgressView(value: progress, total: 100)
                    .onReceive(timer) { _ in
                        if isWatering && progress < 100 {
                            progress += 1.0
                        }
                        
                        if progress >= 100 {
                            // Watering is finished, invalidate the timer
                            timer.upstream.connect().cancel()
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

//#Preview {
//    PlantDetailsView()
//}
