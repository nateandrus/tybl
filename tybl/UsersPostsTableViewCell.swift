//
//  UsersPostsTableViewCell.swift
//  tybl
//
//  Created by Nathan Andrus on 4/4/19.
//  Copyright © 2019 Nathan Andrus. All rights reserved.
//

import UIKit
import FirebaseAuth

class UsersPostsTableViewCell: UITableViewCell {

    @IBOutlet weak var userPostImageView: UIImageView!
    @IBOutlet weak var timestampLabel: UILabel!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    var delegate: UsersPostsTableViewCellDelegate?
    
    var savedPost: TravelPost? {
        didSet{
            updateViews()
        }
    }
   
    @IBAction func deletePostButtonTapped(_ sender: UIButton) {
        delegate?.cellButtonTapped(self)
    }
    
    func updateViews() {
        guard Auth.auth().currentUser == Auth.auth().currentUser, let savedPost = savedPost else { return }
        userPostImageView.image = savedPost.travelImage
//        usernameLabel.text = Auth.auth().currentUser.username
        timestampLabel.text = "\(savedPost.timestamp)"
        descriptionLabel.text = savedPost.description
    }
}

protocol UsersPostsTableViewCellDelegate {
    func cellButtonTapped(_ sender: UsersPostsTableViewCell)
}

    

