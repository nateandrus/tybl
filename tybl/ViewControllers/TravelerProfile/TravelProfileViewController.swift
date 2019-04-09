//
//  TravelProfileViewController.swift
//  tybl
//
//  Created by Nathan Andrus on 3/27/19.
//  Copyright © 2019 Nathan Andrus. All rights reserved.
//

import UIKit

class TravelProfileViewController: UIViewController {
    
    //MARK: - Outlets
    @IBOutlet weak var bucketListTableView: UITableView!
    @IBOutlet weak var userProfileImageView: UIImageView!
    @IBOutlet weak var userProfileSegmentedController: UISegmentedControl!
    @IBOutlet weak var favoriteTravelDestinationButton: UIButton!
    @IBOutlet weak var recentDestinationButton: UIButton!
    
    //MARK: - Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        bucketListTableView.delegate = self
        bucketListTableView.dataSource = self
        userProfileImageView.layer.cornerRadius = userProfileImageView.frame.height / 2
        favoriteTravelDestinationButton.layer.cornerRadius = favoriteTravelDestinationButton.frame.height / 2
        recentDestinationButton.layer.cornerRadius = recentDestinationButton.frame.height / 2
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        guard let user = UserController.shared.loggedInUser else { return }
        self.title = "@\(user.username)"
        if user.profileImage != nil {
            userProfileImageView.image = user.profileImage
        } else {
            userProfileImageView.image = #imageLiteral(resourceName: "3N9A5396")
        }
        BucketListLocationController.shared.fetchCheckedOffBucketListLocations { (success) in
            if success {
                self.bucketListTableView.reloadData()
            }
        }
    }
    

    
    //MARK: - IBActions
    @IBAction func settingsBarButtonTapped(_ sender: UIBarButtonItem) {
        settingsActionSheet()
    }
    @IBAction func userProfileSegmentedController(_ sender: UISegmentedControl) {
        self.bucketListTableView.reloadData()
    }
    @IBAction func favoriteTravelDestinationButtonTapped(_ sender: UIButton) {
        guard let user = UserController.shared.loggedInUser else { return}
        if user.favoriteTravelDestination == nil {
            noFavoriteDestinationAlertController()
        }
    }
    @IBAction func mostRecentDestinationButtonTapped(_ sender: UIButton) {
    }
    
    //MARK: - Helper Functions
    func settingsActionSheet() {
        guard let user = UserController.shared.loggedInUser else { return }
        let actionSheet = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        let changeUsernameAction = UIAlertAction(title: "Change username", style: .default) { (_) in
            self.changeUsernameAlertController()
        }
        let changeUserProfileImageAction = UIAlertAction(title: "Change profile image", style: .default) { (_) in
        }
        let logoutAction = UIAlertAction(title: "Logout", style: .default) { (_) in
            
        }
        if user.favoriteTravelDestination == nil {
            let addFavoriteTravelDestinationAction = UIAlertAction(title: "Set favorite destination", style: .default) { (_) in
            }
            actionSheet.addAction(addFavoriteTravelDestinationAction)
        }
        actionSheet.addAction(cancelAction)
        actionSheet.addAction(changeUsernameAction)
        actionSheet.addAction(changeUserProfileImageAction)
        actionSheet.addAction(logoutAction)
        present(actionSheet, animated: true)
    }
    
    func noFavoriteDestinationAlertController() {
        let alertcontroller = UIAlertController(title: "Favorite travel destination has not been set", message: "This location can be set up in the settings", preferredStyle: .alert)
        let action = UIAlertAction(title: "Ok", style: .default, handler: nil)
        alertcontroller.addAction(action)
        self.present(alertcontroller, animated: true)
    }
    func changeUsernameAlertController() {
        var usernameTextField: UITextField?
        let alertcontroller = UIAlertController(title: "Change username", message: "Choose something sweet", preferredStyle: .alert)
        alertcontroller.addTextField { (textField) in
            textField.placeholder = "Enter new username..."
            usernameTextField = textField
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        let changeAction = UIAlertAction(title: "Change", style: .default) { (_) in
            guard let newUsername = usernameTextField?.text, !newUsername.isEmpty, let user = UserController.shared.loggedInUser else { return }
            UserController.shared.modifyUser(user: user, username: newUsername, profileImage: nil)
            self.title = "@\(newUsername)"
        }
        alertcontroller.addAction(cancelAction)
        alertcontroller.addAction(changeAction)
        present(alertcontroller, animated: true)
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toBucketListDetail" {
            if let indexBL = bucketListTableView.indexPathForSelectedRow {
                if let destinationVC = segue.destination as? BLTypeTableViewController {
                    if userProfileSegmentedController.selectedSegmentIndex == 0 {
                        let bucketListLocation = BucketListLocationController.shared.bucketListLocations[indexBL.row]
                        destinationVC.bucketLandingPad = bucketListLocation
                    }
                    if userProfileSegmentedController.selectedSegmentIndex == 1 {
                        let bucketListLocation = BucketListLocationController.shared.checkedOffBucketListLocations[indexBL.row]
                        destinationVC.bucketLandingPad = bucketListLocation
                    }
                }
            }
        }
        if segue.identifier == "toFavoriteLocation" {
            
        }
        if segue.identifier == "toMostRecentLocation" {
            
        }
    }
}

//MARK: - TableView Functions
extension TravelProfileViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if userProfileSegmentedController.selectedSegmentIndex == 0 {
            return BucketListLocationController.shared.bucketListLocations.count
        } else if userProfileSegmentedController.selectedSegmentIndex == 1 {
            return BucketListLocationController.shared.checkedOffBucketListLocations.count
        } else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let height = tableView.frame.height / 7
        return height
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "bucketListItemCell", for: indexPath)
        if userProfileSegmentedController.selectedSegmentIndex == 0 {
            let bucketListLocation = BucketListLocationController.shared.bucketListLocations[indexPath.row]
            cell.textLabel?.text = bucketListLocation.locationName
            return cell
        } else if userProfileSegmentedController.selectedSegmentIndex == 1 {
            let pastTravelLocation = BucketListLocationController.shared.checkedOffBucketListLocations[indexPath.row]
            cell.textLabel?.text = pastTravelLocation.locationName
//            let cellImage = pastTravelLocation.bucketListItems.first?.travelImage
//            cell.imageView?.layer.cornerRadius = cell.imageView!.frame.height / 2
//            cell.imageView?.layer.masksToBounds = true
//            cell.imageView?.clipsToBounds = true
//            cell.imageView?.contentMode = .scaleAspectFill
//            cell.imageView?.image = cellImage
            return cell
        } else {
            return UITableViewCell()
        }
    }
}
