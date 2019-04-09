//
//  BucketListLocationController.swift
//  tybl
//
//  Created by Nathan Andrus on 4/3/19.
//  Copyright © 2019 Nathan Andrus. All rights reserved.
//

import UIKit
import Firebase

class BucketListLocationController {
    
    let databaseRef = Database.database().reference()
    
    //MARK: - Sington
    static let shared = BucketListLocationController()
    
    //MARK: - Data Sources
    var bucketListLocations: [BucketListLocation] = []
    var checkedOffBucketListLocations: [BucketListLocation] = []
    
    
    //MARK: - CRUD Functions for Bucket List Locations
    func addBucketListLocation() {
    }
    
    func removeBucketListLocation() {
    }
    
    func fetchBucketListLocations(completion: @escaping (Bool) -> Void) {
        
        
    }
    
    func fetchCheckedOffBucketListLocations(completion: @escaping (Bool) -> Void) {
        guard let userFirebaseUID = UserController.shared.loggedInUser?.firebaseUID else { return }
        databaseRef.child("users").child(userFirebaseUID).child("checkedOffBucketList").observeSingleEvent(of: .childAdded) { (snapshot) in
            
            let downloadedLocation = BucketListLocation(from: snapshot)
            
            if let downloadedLocation = downloadedLocation {
                self.checkedOffBucketListLocations.append(downloadedLocation)
            } else {
                print("Error downloading location and turning it into a BUCKETLISTLOCATION 🤬🤬🤬🤬🤬")
                completion(false)
                return
            }
            print("Success turning firebase locations into local locations!!✅✅✅✅✅✅")
            completion(true)
            return 
        }
    }
}
