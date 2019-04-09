//
//  User.swift
//  tybl
//
//  Created by Nathan Andrus on 3/27/19.
//  Copyright © 2019 Nathan Andrus. All rights reserved.
//

import UIKit
import Firebase

class User: NSObject {
    
    var username: String
    var email: String
    var firebaseUID: String?
    var profileImage: UIImage?
    var favoriteTravelDestination: String?
    var mostRecentTravel: String?
    var bucketList: [String]?
    var travelPosts: [String]?
    var travelBuddies: [String]?
    
    init(username: String, email: String, profileImage: UIImage?, favoriteTravelDestination: String?, mostRecentTravel: String?, bucketList: [String] = [], travelPosts: [String]?, travelBuddies: [String]?) {
        self.username = username
        self.email = email
        self.profileImage = profileImage
        self.favoriteTravelDestination = favoriteTravelDestination
        self.mostRecentTravel = mostRecentTravel
        self.bucketList = bucketList
        self.travelPosts = travelPosts
        self.travelBuddies = travelBuddies
    }

////    initialize from Firebase
    init?(from snapshot: DataSnapshot) {
        let snapshotValue = snapshot.value as? [String: Any]

        guard let username = snapshotValue?["username"] as? String,
        let email = snapshotValue?["email"] as? String,
        let firebaseUID = snapshotValue?["firebaseUID"] as? String
        else { return nil }
        
        let favoriteTravelDestination = snapshotValue?["favoriteTravelDestination"] as? String
        let mostRecentTravel = snapshotValue?["mostRecentTravel"] as? String
        let bucketList = snapshotValue?["bucketList"] as? [String]
        let travelPosts = snapshotValue?["travelPosts"] as? [String]
        let travelBuddies = snapshotValue?["travelBuddies"] as? [String]

        self.username = username
        self.firebaseUID = firebaseUID
        self.email = email
        self.favoriteTravelDestination = favoriteTravelDestination
        self.mostRecentTravel = mostRecentTravel
        self.bucketList = bucketList
        self.travelPosts = travelPosts
        self.travelBuddies = travelBuddies
    }
}

