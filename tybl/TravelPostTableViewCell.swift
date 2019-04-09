//
//  TravelPostTableViewCell.swift
//  tybl
//
//  Created by Nathan Andrus on 3/27/19.
//  Copyright © 2019 Nathan Andrus. All rights reserved.
//

import UIKit
import FirebaseAuth

class TravelPostTableViewCell: UITableViewCell {

    @IBOutlet weak var typeImageView: UIImageView!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var postImageView: UIImageView!
    @IBOutlet weak var timestampLabel: UILabel!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    //    weak var delegate: TravelPostTableViewCellDelegate?
    
    var postLanding: TravelPost? {
        didSet {
            updateViews()
        }
    }
    
    @IBAction func addToBLButtonTapped(_ sender: UIButton) {
    }
    
    func updateViews() {
        guard let travelPost = postLanding, let user = UserController.shared.loggedInUser else { return }
        chooseTypePicture()
        typeImageView.layer.cornerRadius = typeImageView.frame.height / 2 
        locationLabel.text = travelPost.location
        postImageView.image = travelPost.travelImage
        timestampLabel.text = Date(timeIntervalSince1970: travelPost.timestamp).stringWith(dateStyle: .medium, timeStyle: .short)
        descriptionLabel.text = travelPost.postDescription
        usernameLabel.text = "@\(user.username)"
    }
    
    func chooseTypePicture() {
        guard let travelPost = postLanding else { return }
        if travelPost.type == "Hotel" {
            typeImageView.backgroundColor = UIColor.yellow
            return typeImageView.image = #imageLiteral(resourceName: "Hotel")
        } else if travelPost.type == "Food" {
            typeImageView.backgroundColor = UIColor.green
            return typeImageView.image = #imageLiteral(resourceName: "Food")
        } else if travelPost.type == "Attraction" {
            typeImageView.backgroundColor = UIColor.orange
            return typeImageView.image = #imageLiteral(resourceName: "Attraction")
        } else if travelPost.type == "Experience" {
            typeImageView.backgroundColor = UIColor.blue
            return typeImageView.image = #imageLiteral(resourceName: "Experience")
        } else {
            typeImageView.backgroundColor = UIColor.gray
            return typeImageView.image = #imageLiteral(resourceName: "Other")
        }
    }
}

//protocol TravelPostTableViewCellDelegate: class {
//    func addToBucketListButtonTapped(_ sender: TravelPostTableViewCell)
//}
