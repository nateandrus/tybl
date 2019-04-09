//
//  Onboarding2ViewController.swift
//  tybl
//
//  Created by Nathan Andrus on 4/2/19.
//  Copyright © 2019 Nathan Andrus. All rights reserved.
//

import UIKit

class Onboarding2ViewController: UIViewController {
    
    //MARK: - Outlets
    @IBOutlet weak var createUsernameTextField: UITextField!
    @IBOutlet weak var signUpButton: UIButton!
    
    //MARK: - Landing Pads for onboarding
    var email: String?
    var password: String?

    //MARK: - Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        signUpButton.layer.cornerRadius = signUpButton.frame.height / 2
    }
    
    //MARK: - IBActions
    @IBAction func signUpButtonTapped(_ sender: UIButton) {
        guard let email = email,
            let password = password,
        let username = createUsernameTextField.text, !username.isEmpty else { return }
        UserController.shared.createUser(username: username, password: password, email: email)
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "TabBarController")
        self.present(vc, animated: true, completion: nil)
    }
}
