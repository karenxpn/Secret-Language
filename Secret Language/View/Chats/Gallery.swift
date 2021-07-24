//
//  Gallery.swift
//  Secret Language
//
//  Created by Karen Mirakyan on 19.07.21.
//

import Foundation
import SwiftUI
import PhotosUI

struct Gallery: UIViewControllerRepresentable {
    @EnvironmentObject var roomVM: MessageRoomViewModel
    
    func makeCoordinator() -> Coordinator {
        return Gallery.Coordinator( parent: self)
    }
    
    func makeUIViewController(context: Context) -> PHPickerViewController {
        var configuration = PHPickerConfiguration()
        configuration.filter = .any(of: [.images, .videos])
        configuration.selectionLimit = 1
        
        let picker = PHPickerViewController(configuration: configuration)
        picker.delegate = context.coordinator
        
        return picker
    }
    
    func updateUIViewController(_ uiViewController: PHPickerViewController, context: Context) {
        
    }
    
    class Coordinator: NSObject, PHPickerViewControllerDelegate {
        var parent: Gallery
        
        init( parent: Gallery) {
            self.parent = parent
        }
        
        func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
            
            if !results.isEmpty {
                
                for media in results {
                    
                    let itemProvider = media.itemProvider
                    
                    guard let typeIdentifier = itemProvider.registeredTypeIdentifiers.first,
                          let utType = UTType(typeIdentifier)
                    else { continue }
                    
                    if utType.conforms(to: .image) {
                        self.getPhoto(from: itemProvider, resultCount: results.count)
                    } else if utType.conforms(to: .movie) {
                        self.getVideo(from: itemProvider, typeIdentifier: typeIdentifier, resultCount: results.count)
                    }  else {
                        self.getPhoto(from: itemProvider, resultCount: results.count)
                    }

                    DispatchQueue.main.async {
                        picker.dismiss()
                    }
                }
                
            } else {
                picker.dismiss(animated: true, completion: nil)
            }
        }
        
        private func getPhoto(from itemProvider: NSItemProvider, resultCount: Int) {
            if itemProvider.canLoadObject(ofClass: UIImage.self) {
                itemProvider.loadObject(ofClass: UIImage.self) { (img, error) in
                    if let uiimage = img as? UIImage {
                        if let imageData = uiimage.fixOrientation()!.jpegData(compressionQuality: 0.4) {
                            DispatchQueue.main.async {
                                self.parent.roomVM.sendMessage(message: SendingMessageModel(type: "image", content: imageData.base64EncodedString()))
                            }
                        }
                    }
                }
            }
        }
        
        private func getVideo(from itemProvider: NSItemProvider, typeIdentifier: String, resultCount: Int) {
            itemProvider.loadFileRepresentation(forTypeIdentifier: typeIdentifier) { url, error in
                if let error = error {
                    print(error.localizedDescription)
                }
                
                guard let url = url else { return }
                
                if let data = try? Data(contentsOf: URL(fileURLWithPath: url.path)) {
                    DispatchQueue.main.async {
                        self.parent.roomVM.sendMessage(message: SendingMessageModel(type: "video", content: data.base64EncodedString()))
                    }
                }
            }
        }
    }
}
