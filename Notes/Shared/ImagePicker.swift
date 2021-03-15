//
//  ImagePicker.swift
//  Notes
//
//  Created by Mac HD on 15/03/21.
//

import Foundation
import UIKit
import SwiftUI


struct ImagePicker: UIViewControllerRepresentable {

    // MARK: - Environment Object
    @Environment(\.presentationMode) var presentationMode
    @Binding var image: UIImage?

    // MARK: - Coordinator Class
    class Coordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
        let parent: ImagePicker

        init(_ parent: ImagePicker) {
            self.parent = parent
        }

        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
            if let uiImage = info[.originalImage] as? UIImage {
                parent.image = uiImage
            }
            parent.presentationMode.wrappedValue.dismiss()
        }
    }

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    func makeUIViewController(context: UIViewControllerRepresentableContext<ImagePicker>) -> UIImagePickerController {        let picker = UIImagePickerController()
        picker.delegate = context.coordinator
        picker.allowsEditing = false
        #if targetEnvironment(simulator)
        picker.sourceType = .savedPhotosAlbum
        #else
        picker.sourceType = .photoLibrary
        #endif
        return picker
    }

    func updateUIViewController(_ uiViewController: UIImagePickerController, context: UIViewControllerRepresentableContext<ImagePicker>) {

    }
}

