//
//  OnboardViewController.swift
//  tybl
//
//  Created by Nathan Andrus on 4/2/19.
//  Copyright © 2019 Nathan Andrus. All rights reserved.
//

import UIKit

class OnboardViewController: UIViewController {

    //MARK: - Outlets
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var createPasswordTextField: UITextField!
    @IBOutlet weak var confirmPasswordTextField: UITextField!
    @IBOutlet weak var nextButton: UIButton!
    
    //MARK: - Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        nextButton.layer.cornerRadius = nextButton.frame.height / 2
    }
    
    //MARK: - IBActions
    @IBAction func nextButtonTapped(_ sender: UIButton) {
    }
    
    //MARK: - Helper Functions
    func presentSimpleAlertController() {
        let alertController = UIAlertController(title: "Password", message: "It looks like your passwords did not match up. Try one more time!", preferredStyle: .alert)
        let action = UIAlertAction(title: "Ok", style: .default, handler: nil)
        alertController.addAction(action)
        present(alertController, animated: true)
    }
    
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let createPassword = createPasswordTextField.text, !createPassword.isEmpty,
            let confirmPassword = confirmPasswordTextField.text, !confirmPassword.isEmpty,
            let email = emailTextField.text, !email.isEmpty else { return }
        if createPassword == confirmPassword {
            if segue.identifier == "toOnboarding2" {
                let destinationVC = segue.destination as? Onboarding2ViewController
                destinationVC?.password = createPassword
                destinationVC?.email = email
            }
        } else {
            presentSimpleAlertController()
        }
    }
}
