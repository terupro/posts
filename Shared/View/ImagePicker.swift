//
//  ImagePicker.swift
//  Reminisce
//
//  Created by Teruya Hasegawa on 2021/11/27.
//

import SwiftUI
import PhotosUI

struct ImagePicker : UIViewControllerRepresentable {
    
    func makeCoordinator() -> Coordinator {
        return ImagePicker.Coordinator(parent1: self)
    }
    
    @Binding var imageData : Data
    @Binding var picker : Bool
    
    func makeUIViewController(context: Context) -> PHPickerViewController {
        
        var config = PHPickerConfiguration()
        // you can also select videos using this picker....
        config.filter = .images
        // 0 is used for multiple selection....
        config.selectionLimit = 1
        let picker = PHPickerViewController(configuration: config)
        // addigning delegate...
        picker.delegate = context.coordinator
        return picker
    }
    
    func updateUIViewController(_ uiViewController: PHPickerViewController, context: Context) {
        
    }
    
    class Coordinator: NSObject,PHPickerViewControllerDelegate{
        
        var parent : ImagePicker
        
        init(parent1: ImagePicker) {
            
            parent = parent1
        }
        
        func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
            
            // closing picker...
            
            parent.picker.toggle()
            
            for img in results{
                
                // checking whether the image can be loaded...
                
                if img.itemProvider.canLoadObject(ofClass: UIImage.self){
                    
                    // retreving the selected Image...
                    
                    img.itemProvider.loadObject(ofClass: UIImage.self) { (image, err) in
                        
                        guard let image1 = image else {
                            return
                        }
                        
                        // appending image...
                        
                        self.parent.imageData = (image1 as! UIImage).jpegData(compressionQuality: 0.5)!
                    }
                }
                else{
                    
                    // cannot be loaded
                    
                    print("cannot be loaded")
                }
            }
        }
    }
}
