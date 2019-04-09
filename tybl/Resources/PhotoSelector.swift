//
//  PhotoSelector.swift
//  tybl
//
//  Created by Nathan Andrus on 3/27/19.
//  Copyright © 2019 Nathan Andrus. All rights reserved.
//

import Foundation

//extension PhotoSelectorViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
//    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
//        picker.dismiss(animated: true, completion: nil)
//        if let photo = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
//            selectPhotoButton.setTitle("", for: .normal)
//            photoImageView.image = photo
//            delegate?.photoSelectorViewControllerSelected(image: photo)
//        }
//    }
//
//    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
//        picker.dismiss(animated: true, completion: nil)
//    }
//
//    func presentImagePickerActionSheet() {
//        let imagePickerController = UIImagePickerController()
//        imagePickerController.delegate = self
//        let actionSheet = UIAlertController(title: "Select a Photo", message: nil, preferredStyle: .actionSheet)
//        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary){
//            actionSheet.addAction(UIAlertAction(title: "Photos", style: .default, handler: { (_) in
//                imagePickerController.sourceType = UIImagePickerController.SourceType.photoLibrary
//                self.present(imagePickerController, animated: true, completion: nil)
//            }))
//        }
//        if UIImagePickerController.isSourceTypeAvailable(.camera){
//            actionSheet.addAction(UIAlertAction(title: "Camera", style: .default, handler: { (_) in
//                imagePickerController.sourceType = UIImagePickerController.SourceType.camera
//                self.present(imagePickerController, animated: true, completion: nil)
//            }))
//        }
//        actionSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
//        present(actionSheet, animated: true)
//    }
//}
