//
//  AddNewPlantView.swift
//  PlantPulseApp
//
//  Created by Mohammed Shaheen on 21.11.23.
//

import SwiftUI
import CoreData
import PhotosUI

struct AddNewPlantView: View {
    
    @State private var plantName : String = ""
    @State private var selectedPlantType : Plants = .aster
    @State private var creationDate : Date = Date.now
    @Binding var isPlantAdded : Bool
    
    @Environment (\.dismiss) var dismiss
    @Environment (\.managedObjectContext) var moc
    
    @State private var showSheet : Bool = false
    @State private var showImagePicker : Bool = false
    @State private var sourceType : UIImagePickerController.SourceType = .camera
    @State private var image : UIImage?
    
    @State private var showCamera = false
    
    var body: some View {
        NavigationStack {
            VStack {
                Image(uiImage: image ?? UIImage(named: "question")!)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 200, height: 200)
                    .clipShape(Circle())
                    .shadow(radius: 10)
                Button("Change picture") {
                    showSheet = true
                }
                .foregroundStyle(.white)
                
                List {
                    TextField("Plant name", text: $plantName, axis: .vertical)
                        .padding(10)
                    
                    Picker("Select plant type", selection: $selectedPlantType) {
                        ForEach(Plants.allCases.sorted(by: { $0.rawValue < $1.rawValue}), id: \.self) { plant in
                            Text(plant.plantType)
                                .tag(plant)
                        }
                    }
                    .pickerStyle(.navigationLink)
                    .padding(10)
                    
                    DatePicker("Date planted/bought", selection: $creationDate, in: ...Date.now, displayedComponents: .date)
                        .padding(10)
                }
                .listStyle(.inset)
            }
            .background(.linearGradient(colors: [.purple, .blue], startPoint: .topLeading, endPoint: .bottomTrailing))
            .confirmationDialog("Choose method", isPresented: $showSheet, titleVisibility: .visible) {
                
                Button("Take a picture") {
                    showCamera = true
                }
                
                Button("Choose from library") {
                    self.showImagePicker = true
                    self.sourceType = .photoLibrary
                }
                
                Button("Cancel", role: .cancel) {}
            }
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button(action: {
                        dismiss()
                    }, label: {
                        Image(systemName: "xmark")
                    })
                    .foregroundStyle(.white)
                }
                
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Add") {
                        DataManager().addPlant(plantName: plantName, plantType: selectedPlantType.rawValue, date: creationDate, plantImage: image?.toPngString() ?? "question", context: moc)
                        isPlantAdded = true
                        dismiss()
                    }
                    .foregroundStyle(.white)
                }
            }
            .sheet(isPresented: $showImagePicker, content: {
                ImagePicker(image: $image)
            })
            .fullScreenCover(isPresented: $showCamera, content: {
                accessCameraView(selectedImage: self.$image)
            })
        }
    }
}

#Preview {
    AddNewPlantView(isPlantAdded: .constant(false))
}

struct accessCameraView: UIViewControllerRepresentable {
    
    @Binding var selectedImage: UIImage?
    @Environment (\.dismiss) var dismiss
    
    func makeUIViewController(context: Context) -> UIImagePickerController {
        let imagePicker = UIImagePickerController()
        imagePicker.sourceType = .camera
        imagePicker.allowsEditing = true
        imagePicker.delegate = context.coordinator
        return imagePicker
    }
    
    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {
        
    }
    
    func makeCoordinator() -> Coordinator {
        return Coordinator(picker: self)
    }
}
