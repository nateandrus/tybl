//
//  SearchResultsTableViewCell.swift
//  tybl
//
//  Created by Nathan Andrus on 4/3/19.
//  Copyright © 2019 Nathan Andrus. All rights reserved.
//

import UIKit

class SearchResultsTableViewCell: UITableViewCell {

    @IBOutlet weak var typeOfPostImageView: UIImageView!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var postImageView: UIImageView!
    @IBOutlet weak var timestampLabel: UILabel!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    var postLanding: TravelPost? {
        didSet {
            updateViews()
        }
    }
    
    func updateViews() {
        guard let travelPost = postLanding else { return }
        chooseTypePicture()
        locationLabel.text = travelPost.location
        postImageView.image = travelPost.travelImage
        timestampLabel.text = "\(travelPost.timestamp)"
//        usernameLabel.text = post.creatorUUID
        descriptionLabel.text = travelPost.postDescription
    }
    
    func chooseTypePicture() {
        guard let travelPost = postLanding else { return }
        if travelPost.type == "Hotel" {
            typeOfPostImageView.backgroundColor = UIColor.yellow
            return typeOfPostImageView.image = #imageLiteral(resourceName: "Hotel")
        } else if travelPost.type == "Food" {
            typeOfPostImageView.backgroundColor = UIColor.green
            return typeOfPostImageView.image = #imageLiteral(resourceName: "Food")
        } else if travelPost.type == "Attraction" {
            typeOfPostImageView.backgroundColor = UIColor.orange
            return typeOfPostImageView.image = #imageLiteral(resourceName: "Attraction")
        } else if travelPost.type == "Experience" {
            typeOfPostImageView.backgroundColor = UIColor.blue
            return typeOfPostImageView.image = #imageLiteral(resourceName: "Experience")
        } else {
            typeOfPostImageView.backgroundColor = UIColor.gray
            return typeOfPostImageView.image = #imageLiteral(resourceName: "Other")
        }
    }
}
