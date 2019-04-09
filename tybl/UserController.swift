//
//  UserController.swift
//  tybl
//
//  Created by Nathan Andrus on 3/27/19.
//  Copyright © 2019 Nathan Andrus. All rights reserved.


import UIKit
import Firebase
import FirebaseDatabase
import FirebaseAuth

class UserController {
    
    let rootRef = Database.database().reference()
    let childRef = Database.database().reference(withPath: "users")
    
    //MARK: - Singleton
    static let shared = UserController()
    
    //MARK: - LandingPads
    var loggedInUser: User?
    
    //MARK: - CRUD Functions for Users
    func createUser(username: String, password: String, email: String) {
        //Add user locally and set loggedInUser to newUser
        let newUser = User(username: username, email: email, profileImage: nil, favoriteTravelDestination: nil, mostRecentTravel: nil, travelPosts: nil, travelBuddies: nil)
        //Add user in firebase
        Auth.auth().createUser(withEmail: email, password: password) { (authCall, error) in
            if let error = error {
                print("problem creating user : \(error.localizedDescription)")
            }
            guard let authCall = authCall else { return }
            self.childRef.child(authCall.user.uid).child("username").setValue(newUser.username)
            self.childRef.child(authCall.user.uid).child("email").setValue(newUser.email)
            self.childRef.child(authCall.user.uid).child("firebaseUID").setValue(authCall.user.uid)
            self.childRef.child(authCall.user.uid).child("profileImage").setValue("notset")
            self.childRef.child(authCall.user.uid).child("favoriteTravelDestination").setValue("notset")
            self.childRef.child(authCall.user.uid).child("mostRecentTravel").setValue("notset")
            self.childRef.child(authCall.user.uid).child("bucketList").setValue("\(newUser.username)bucketList")
            self.childRef.child(authCall.user.uid).child("checkedOffBucketList").setValue("\(newUser.username)checkedOffBucketList")
            print("\(authCall) was a success✅")
        }
    }
    
    func modifyUser(user: User, username: String?, profileImage: UIImage?) {
        if username != nil {
            user.username = username!
        }
        if profileImage != nil {
            user.profileImage = profileImage
        }
    }
    
    func logoutUser() {
    }
    
    func loginUser(email: String, password: String, completion: @escaping (Bool) -> Void) {
        Auth.auth().signIn(withEmail: email, password: password) { callResult, error in
            if let error = error {
                print("\(error.localizedDescription)🤬")
                completion(false)
                return
            }
            guard let callResult = callResult else { completion(false); return }
            let useruuid = callResult.user.uid
            self.findUserWithUUID(usingUUID: useruuid, completion: { (user) in
                if let error = error {
                    print("Making user out of call back was unsuccessful 🤬🤬🤬🤬🤬🤬🤬🤬 : \(error.localizedDescription)")
                    completion(false)
                    return
                }
                print("Login was a success!! ✅")
                completion(true)
            })
        }
    }
    
    func findUserWithUUID(usingUUID: String, completion: @escaping (Bool) -> Void) {
//        let authUserUUID = Auth.auth().currentUser?.uid
        rootRef.child("users").child(usingUUID).observeSingleEvent(of: .value, with: { (snapshot) in

                let user = User(from: snapshot)

                if let user = user {
                    self.loggedInUser = user
                    completion(true)
                } else {
                    completion(false)
                }
        }, withCancel: nil)
    }
}
