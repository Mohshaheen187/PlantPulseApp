//
//  PlantDetailsView.swift
//  PlantPulseApp
//
//  Created by Mohammed Shaheen on 21.11.23.
//

import SwiftUI

struct PlantDetailsView: View {
    
    var plants : FetchedResults<Plant>.Element
    
    var body: some View {
        Text(plants.plantType!)
    }
}

//#Preview {
//    PlantDetailsView()
//}
