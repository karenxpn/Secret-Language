//
//  ProfileImagePicker.swift
//  Secret Language
//
//  Created by Karen Mirakyan on 24.06.21.
//

import Foundation
import SwiftUI
import PhotosUI

struct ProfileImagePicker: UIViewControllerRepresentable {
    
    @EnvironmentObject var profileVM: ProfileViewModel
    
    func makeCoordinator() -> Coordinator {
        return ProfileImagePicker.Coordinator( parent: self)
    }
    
    func makeUIViewController(context: Context) -> PHPickerViewController {
        var configuration = PHPickerConfiguration()
        configuration.filter = .images
        configuration.selectionLimit = 1
        
        let picker = PHPickerViewController(configuration: configuration)
        picker.delegate = context.coordinator
        
        return picker
    }
    
    func updateUIViewController(_ uiViewController: PHPickerViewController, context: Context) {
        
    }
    
    class Coordinator: NSObject, PHPickerViewControllerDelegate {
        var partent: ProfileImagePicker
        
        init( parent: ProfileImagePicker) {
            self.partent = parent
        }
        
        func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
            
            if !results.isEmpty {
                if results.first!.itemProvider.canLoadObject(ofClass: UIImage.self ) {
                    results.first!.itemProvider.loadObject(ofClass: UIImage.self) { (image, error) in
                        if let uiImage = image as? UIImage {
                            if let imageData = uiImage.fixOrientation()!.jpegData(compressionQuality: 0.8) {
                                DispatchQueue.main.async {
                                    self.partent.profileVM.addProfileImage(image: imageData)
                                    picker.dismiss()
                                }
                            }
                        }
                    }
                }
            } else {
                picker.dismiss(animated: true, completion: nil)
            }
        }
    }
}
