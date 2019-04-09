//
//  TravelPost.swift
//  tybl
//
//  Created by Nathan Andrus on 3/27/19.
//  Copyright © 2019 Nathan Andrus. All rights reserved.


import UIKit
import Firebase

class TravelPost: NSObject {
    
    let location: String
    let postDescription: String
    let timestamp: Double
    var travelImage: UIImage?
    var travelImageURL: String?
    let type: String
    let creatorUUID: String
    let postUUID: String
    
    init(location: String, description: String, timestamp: Double, travelImage: UIImage, type: String, postUUID: String = UUID().uuidString, creatorUUID: String) {
        self.timestamp = timestamp
        self.travelImage = travelImage
        self.location = location
        self.postDescription = description
        self.type = type
        self.creatorUUID = creatorUUID
        self.postUUID = postUUID
    }
    
    init?(from snapshot: DataSnapshot) {
        let snapshot = snapshot.value as? [String: Any]
        
        guard let location = snapshot?["location"] as? String,
            let postDescription = snapshot?["postDescription"] as? String,
            let timestamp = snapshot?["timestamp"] as? Double,
            let travelImageURL = snapshot?["imageURL"] as? String,
            let type = snapshot?["type"] as? String,
            let creatorUUID = snapshot?["userThatPosted"] as? String,
            let postUUID = snapshot?["postFBuid"] as? String
            else { return nil }
        
        self.location = location
        self.postDescription = postDescription
        self.timestamp = timestamp
        self.travelImageURL = travelImageURL
        self.type = type
        self.creatorUUID = creatorUUID
        self.postUUID = postUUID
    }
}
