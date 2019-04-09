//
//  CreateTravelPostViewController.swift
//  tybl
//
//  Created by Nathan Andrus on 3/27/19.
//  Copyright © 2019 Nathan Andrus. All rights reserved.
//

import UIKit

class CreateTravelPostViewController: UIViewController {
    
    //MARK: - Outlets
    @IBOutlet weak var postImage: UIImageView!
    @IBOutlet weak var selectImageButton: UIButton!
    @IBOutlet weak var attractionButton: UIButton!
    @IBOutlet weak var hotelButton: UIButton!
    @IBOutlet weak var foodButton: UIButton!
    @IBOutlet weak var experienceButton: UIButton!
    @IBOutlet weak var otherButton: UIButton!
    
    //MARK: - Landing Pads
    var postType: String?
    var selectedImage: UIImage?
    
    var fromCreate: Bool = false
    
    //MARK: - Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        attractionButton.layer.cornerRadius = attractionButton.frame.height / 2
        hotelButton.layer.cornerRadius = hotelButton.frame.height / 2
        foodButton.layer.cornerRadius = foodButton.frame.height / 2
        experienceButton.layer.cornerRadius = experienceButton.frame.height / 2
        otherButton.layer.cornerRadius = otherButton.frame.height / 2
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if fromCreate {
            resetViews()
            fromCreate = false
            tabBarController?.selectedIndex = 4
        }
    }
    
    func resetViews() {
        postImage.image = nil
        selectImageButton.setTitle("Select photo", for: .normal)
        attractionButton.backgroundColor = .white
        attractionButton.setTitleColor(.black, for: .normal)
        experienceButton.backgroundColor = .white
        experienceButton.setTitleColor(.black, for: .normal)
        hotelButton.backgroundColor = .white
        hotelButton.setTitleColor(.black, for: .normal)
        foodButton.backgroundColor = .white
        foodButton.setTitleColor(.black, for: .normal)
        otherButton.backgroundColor = .white
        otherButton.setTitleColor(.black, for: .normal)
        postType = nil
    }
    
    //MARK: - IBActions
    @IBAction func selectImageButtonTapped(_ sender: UIButton) {
        presentImagePickerActionSheet()
    }
    
    @IBAction func attractionButtonTapped(_ sender: UIButton) {
        hotelButton.backgroundColor = .white
        hotelButton.setTitleColor(.black, for: .normal)
        foodButton.backgroundColor = .white
        foodButton.setTitleColor(.black, for: .normal)
        experienceButton.backgroundColor = .white
        experienceButton.setTitleColor(.black, for: .normal)
        otherButton.backgroundColor = .white
        otherButton.setTitleColor(.black, for: .normal)
        attractionButton.backgroundColor = .black
        attractionButton.setTitleColor(.white, for: .normal)
        postType = "Attraction"
    }
    @IBAction func hotelButtonTapped(_ sender: UIButton) {
        attractionButton.backgroundColor = .white
        attractionButton.setTitleColor(.black, for: .normal)
        foodButton.backgroundColor = .white
        foodButton.setTitleColor(.black, for: .normal)
        experienceButton.backgroundColor = .white
        experienceButton.setTitleColor(.black, for: .normal)
        otherButton.backgroundColor = .white
        otherButton.setTitleColor(.black, for: .normal)
        hotelButton.backgroundColor = .black
        hotelButton.setTitleColor(.white, for: .normal)
        postType = "Hotel"
    }
    @IBAction func foodButtonTapped(_ sender: UIButton) {
        attractionButton.backgroundColor = .white
        attractionButton.setTitleColor(.black, for: .normal)
        hotelButton.backgroundColor = .white
        hotelButton.setTitleColor(.black, for: .normal)
        experienceButton.backgroundColor = .white
        experienceButton.setTitleColor(.black, for: .normal)
        otherButton.backgroundColor = .white
        otherButton.setTitleColor(.black, for: .normal)
        foodButton.backgroundColor = .black
        foodButton.setTitleColor(.white, for: .normal)
        postType = "Food"
    }
    @IBAction func experienceButtonTapped(_ sender: UIButton) {
        attractionButton.backgroundColor = .white
        attractionButton.setTitleColor(.black, for: .normal)
        hotelButton.backgroundColor = .white
        hotelButton.setTitleColor(.black, for: .normal)
        foodButton.backgroundColor = .white
        foodButton.setTitleColor(.black, for: .normal)
        otherButton.backgroundColor = .white
        otherButton.setTitleColor(.black, for: .normal)
        experienceButton.backgroundColor = .black
        experienceButton.setTitleColor(.white, for: .normal)
        postType = "Experience"
    }
    @IBAction func otherButtonTapped(_ sender: UIButton) {
        attractionButton.backgroundColor = .white
        attractionButton.setTitleColor(.black, for: .normal)
        hotelButton.backgroundColor = .white
        hotelButton.setTitleColor(.black, for: .normal)
        foodButton.backgroundColor = .white
        foodButton.setTitleColor(.black, for: .normal)
        experienceButton.backgroundColor = .white
        experienceButton.setTitleColor(.black, for: .normal)
        otherButton.backgroundColor = .black
        otherButton.setTitleColor(.white, for: .normal)
        postType = "Other"
    }
    
    // MARK: - Navigation
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        if let _ = postType, let _ = selectedImage {
            return true
        } else {
            return false
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let poostType = postType, let image = selectedImage else { return }
        if segue.identifier == "toPage2VC" {
            let destinationVC = segue.destination as? Page2CreateViewController
            destinationVC?.image = image
            destinationVC?.postType = poostType
        }
    }
}

//MARK: - Image Picker Extension
extension CreateTravelPostViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true, completion: nil)
        if let photo = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            selectImageButton.setTitle("", for: .normal)
            postImage.image = photo
            selectedImage = photo
        }
    }
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    func presentImagePickerActionSheet() {
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        let actionSheet = UIAlertController(title: "Select a Photo", message: nil, preferredStyle: .actionSheet)
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary){
            actionSheet.addAction(UIAlertAction(title: "Photos", style: .default, handler: { (_) in
                imagePickerController.sourceType = UIImagePickerController.SourceType.photoLibrary
                self.present(imagePickerController, animated: true, completion: nil)
            }))
        }
        actionSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        present(actionSheet, animated: true)
    }
}

