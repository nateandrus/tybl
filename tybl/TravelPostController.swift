//
//  TravelPostController.swift
//  tybl
//
//  Created by Nathan Andrus on 3/27/19.
//  Copyright © 2019 Nathan Andrus. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseStorage

class TravelPostController {
    
    let rootRef = Database.database().reference()
    let childRef = Database.database().reference(withPath: "posts")
    
    //MARK: - Singleton
    static let shared = TravelPostController()
    
    //MARK: - Data source
    var travelPostsForFeed: [TravelPost] = []
    var savedTravelPosts: [TravelPost] = []
    var searchResultsPosts: [TravelPost] = []
    
    
    //MARK: - CRUD Functions for Travel Posts
    func addTravelPost(location: String, image: UIImage, description: String, type: String) {
        //Add post locally
        let postUUID = UUID().uuidString
        guard let creatorUUID = Auth.auth().currentUser?.uid else { return }
        let bucketListUUID = UUID().uuidString
        let location = BucketListLocation(name: location, bucketListUUID: bucketListUUID, postUIDs: [])
        let newPost = TravelPost(location: location.locationName, description: description, timestamp: Date().timeIntervalSince1970, travelImage: image, type: type, postUUID: postUUID, creatorUUID: creatorUUID)
        //upload photo to firebase
        let storage = Storage.storage().reference().child(newPost.postUUID)
        guard let uploadData = image.pngData() else { return }
        storage.putData(uploadData, metadata: nil) { (metaData, error ) in
            if let error = error {
                print("\(error.localizedDescription)🤬🤬🤬🤬🤬")
                return
            }
            print(metaData!)
            storage.downloadURL(completion: { (url, error) in
                if let error = error {
                    print("\(error.localizedDescription)🤬🤬🤬🤬🤬🤬")
                    return
                }
                guard let url = url, let userFirebaseUID = UserController.shared.loggedInUser?.firebaseUID else { return }
                let urlAsString = url.absoluteString
                self.childRef.child(newPost.postUUID).child("imageURL").setValue(urlAsString)
                self.childRef.child(newPost.postUUID).child("location").setValue(newPost.location)
                self.childRef.child(newPost.postUUID).child("postDescription").setValue(newPost.postDescription)
                self.childRef.child(newPost.postUUID).child("timestamp").setValue(newPost.timestamp)
                self.childRef.child(newPost.postUUID).child("type").setValue(newPost.type)
                self.childRef.child(newPost.postUUID).child("userThatPosted").setValue(Auth.auth().currentUser!.uid)
                self.childRef.child(newPost.postUUID).child("postFBuid").setValue(newPost.postUUID)
                self.rootRef.child("users").child(userFirebaseUID).child("checkedOffBucketList").child(newPost.location)
                self.rootRef.child("users").child(userFirebaseUID).child("checkedOffBucketList").child(newPost.location).child("bucketListUUID").setValue(location.bucketListUUID)
            })
        }
    }
    
    func fetchBucketListLocations() {
        //List of a users bucket list locations
    }
    
    func fetchPostsForLocation(type: String, location: String, completion: @escaping (Bool) -> Void) {
        
    }
    
    func fetchImagesForPost(post: TravelPost, completion: @escaping (Bool) -> Void) {
        guard let urlAsString = post.travelImageURL else { return }
        let urlReference = Storage.storage().reference().child("002E5F6C-348F-4CE6-AA3D-74B50B6F4EA0")
        urlReference.getData(maxSize: 1 * 10000 * 10000) { (data, error) in
            if let error = error {
                print("Error fetching image from URL :: \(error.localizedDescription)💩💩💩💩💩💩")
                completion(false)
                return
            }
            guard let data = data else { return }
            let image = UIImage(data: data)
            post.travelImage = image
            completion(true)
            return
        }
    }
    
    func fetchAllPosts(completion: @escaping (Bool) -> Void) {
        
        self.childRef.observeSingleEvent(of: .value) { (snapshot) in
            TravelPostController.shared.travelPostsForFeed.removeAll()
            for post in snapshot.children {
                let postObj = post as! DataSnapshot
                guard let post = TravelPost(from: postObj).self else { return }
                self.travelPostsForFeed.append(post)
            }
            completion(true)
        }
    }
    
    
    
    func removePostFromBucketListLocation() {
        
    }
    
    func reportTravelPost() {
        
    }
    
//    func sortCategoryPosts(location: BucketListLocation, categoryType: String) {
//        savedTravelPosts.removeAll()
//        for post in location.postUIDs {
//            if post.type == categoryType {
//                self.savedTravelPosts.append(post)
//            }
//        }
//    }
}


