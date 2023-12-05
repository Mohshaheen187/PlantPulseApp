//
//  HomeTabView.swift
//  PlantPulseApp
//
//  Created by Mohammed Shaheen on 30.11.23.
//

import SwiftUI

struct HomeTabView: View {
    
    @State private var selectedIndex : Int = 1
    @StateObject private var manager = DataManager()
    
    var body: some View {
        TabView(selection: $selectedIndex) {
            MainView()
                .tag(1)
                .tabItem {
                    Label("Dashboard", systemImage: "house")
                }
                .environment(\.managedObjectContext, manager.container.viewContext)
            
            PlantsInfo()
                .tag(2)
                .tabItem {
                    Label("Plants", systemImage: "camera.macro")
                }
        }
        .tint(.black)
    }
}

#Preview {
    HomeTabView()
}
