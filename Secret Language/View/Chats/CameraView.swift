//
//  CameraView.swift
//  Secret Language
//
//  Created by Karen Mirakyan on 20.07.21.
//

import SwiftUI
import PhotosUI

struct CameraView: UIViewControllerRepresentable {
    
    @EnvironmentObject var roomVM: MessageRoomViewModel
    
    func makeCoordinator() -> Coordinator {
        return CameraView.Coordinator(parent: self)
    }
        
    func makeUIViewController(context: Context) -> UIImagePickerController {
        
        let picker = UIImagePickerController()
        picker.sourceType = .camera
        picker.allowsEditing = true
        picker.delegate = context.coordinator
        return picker
    }
    
    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {
        
    }
    
    class Coordinator: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
        
        var parent: CameraView
        
        init( parent: CameraView ) {
            self.parent = parent
        }
        
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            if let uiImage = info[UIImagePickerController.InfoKey.editedImage] as? UIImage {
                if let imageData = uiImage.jpegData(compressionQuality: 0.9) {
                    DispatchQueue.main.async {
                        self.parent.roomVM.sendMessage(message:
                                                        SendingMessageModel(type: "image",
                                                                            content: imageData.base64EncodedString()))
                        
                        picker.dismiss()
                    }
                }
            } else {
                picker.dismiss(animated: true, completion: nil)
            }
        }
    }
}
