//
//  BucketListLocation.swift
//  tybl
//
//  Created by Nathan Andrus on 3/27/19.
//  Copyright © 2019 Nathan Andrus. All rights reserved.
//

import Foundation
import Firebase

class BucketListLocation: NSObject {
    
    let locationName: String
    let bucketListUUID: String
    var postUIDs: [String]?
    
    init(name: String, bucketListUUID: String = UUID().uuidString, postUIDs: [String]) {
        self.locationName = name
        self.bucketListUUID = bucketListUUID
        self.postUIDs = postUIDs
    }
    
    init?(from snapshot: DataSnapshot) {
        let snapshot = snapshot.value as? [String: Any]
        
        guard let locationName = snapshot?["locationName"] as? String,
            let bucketListUUID = snapshot?["bucketListUUID"] as? String
            else { return nil }
        
        if let postUIDs = snapshot?["postUIDs"] as? [String] {
            self.postUIDs = postUIDs
        }
        
        self.locationName = locationName
        self.bucketListUUID = bucketListUUID
    }
}
