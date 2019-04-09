//
//  SavedPostTableViewCell.swift
//  tybl
//
//  Created by Nathan Andrus on 4/3/19.
//  Copyright © 2019 Nathan Andrus. All rights reserved.
//

import UIKit

class UsersOwnPostsCell: UITableViewCell {

    
    @IBOutlet weak var savedPostImageView: UIImageView!
    @IBOutlet weak var timestampLabel: UILabel!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    var delegate: SavedPostTableViewCellDelegate?
    
    var savedPost: TravelPost? {
        didSet{
            updateViews()
        }
    }
    
    @IBAction func postButtonTapped(_ sender: UIButton) {
        delegate?.cellButtonTapped(self)
    }
    
    func updateViews() {
        guard let savedPost = savedPost else { return }
        savedPostImageView.image = savedPost.travelImage
//        usernameLabel.text = savedPost.creatorUUID
        timestampLabel.text = savedPost.timestamp.stringWith(dateStyle: .medium, timeStyle: .short)
        descriptionLabel.text = savedPost.description
    }
}

protocol SavedPostTableViewCellDelegate {
    func cellButtonTapped(_ sender: UsersOwnPostsCell)
}
