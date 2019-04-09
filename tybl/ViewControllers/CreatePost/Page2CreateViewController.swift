//
//  Page2CreateViewController.swift
//  tybl
//
//  Created by Nathan Andrus on 3/31/19.
//  Copyright © 2019 Nathan Andrus. All rights reserved.
//

import UIKit

class Page2CreateViewController: UIViewController {
    
    //MARK: - Outlets
    @IBOutlet weak var postImageView: UIImageView!
    @IBOutlet weak var typeOfPostLabel: UILabel!
    @IBOutlet weak var locationTextField: UITextField!
    @IBOutlet weak var descriptionTextView: UITextView!
    
    //MARK: - Landing pad from segue
    var image: UIImage?
    var postType: String?

    //MARK: - Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        descriptionTextView.layer.borderColor = UIColor.gray.cgColor
        descriptionTextView.layer.borderWidth = 1
        postImageView.image = image
        typeOfPostLabel.text = postType
    }
    
    //MARK: - IBActions
    @IBAction func createPostButtonTapped(_ sender: UIBarButtonItem) {
//       guard let user = UserController.shared.loggedInUser,
        guard let location = locationTextField.text, !location.isEmpty,
        let description = descriptionTextView.text, !description.isEmpty,
        let image = image,
        let postType = postType
        else { return }
        TravelPostController.shared.addTravelPost(location: location, image: image, description: description, type: postType)
        let mainVC = self.navigationController?.viewControllers.first as? CreateTravelPostViewController
        mainVC?.fromCreate = true
        self.navigationController?.popViewController(animated: true)
    }
}
