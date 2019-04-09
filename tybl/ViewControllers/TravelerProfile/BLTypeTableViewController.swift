//
//  BLTypeTableViewController.swift
//  tybl
//
//  Created by Nathan Andrus on 3/29/19.
//  Copyright © 2019 Nathan Andrus. All rights reserved.
//

import UIKit

class BLTypeTableViewController: UITableViewController {
    
    //MARK: - Landing Pad for Bucket List Location
    var bucketLandingPad: BucketListLocation?
    
    //MARK: - Constants used for category type
    let categories: [String] = ["Attraction", "Experience", "Food", "Hotel", "Other"]
    let imageForCategory: [UIImage] = [#imageLiteral(resourceName: "Attraction"), #imageLiteral(resourceName: "Experience"), #imageLiteral(resourceName: "Food"), #imageLiteral(resourceName: "Hotel"), #imageLiteral(resourceName: "Other")]

    //MARK: - Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let bucketListLocation = bucketLandingPad else { return }
        self.title = bucketListLocation.locationName
    }
    
    //MARK: - TableView Delegate methods
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "categoryCell", for: indexPath)
        cell.imageView?.image = imageForCategory[indexPath.row]
        guard let height = cell.imageView?.frame.height else { return UITableViewCell() }
        cell.imageView?.layer.cornerRadius = (height / 2)
        cell.textLabel?.text = categories[indexPath.row]
        return cell
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toSavedPosts" {
            guard let bucketListItemToPass = bucketLandingPad else { return }
            if let index = tableView.indexPathForSelectedRow {
                if let destinationVC = segue.destination as? SavedCategoryPostsTableViewController {
                    destinationVC.categoryLanding = categories[index.row]
                    destinationVC.bucketListLocationLanding = bucketListItemToPass
                }
            }
        }
    }
}
