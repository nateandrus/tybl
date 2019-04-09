//
//  SavedCategoryPostsTableViewController.swift
//  tybl
//
//  Created by Nathan Andrus on 4/1/19.
//  Copyright © 2019 Nathan Andrus. All rights reserved.
//

import UIKit

class SavedCategoryPostsTableViewController: UITableViewController, UsersPostsTableViewCellDelegate {
    
    //MARK: - Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let category = categoryLanding else { return }
        self.title = category
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        guard let location = bucketListLocationLanding, let category = categoryLanding else { return }
//        TravelPostController.shared.sortCategoryPosts(location: location, categoryType: category)
    }
    
    //MARK: - Landing Pads
    var bucketListLocationLanding: BucketListLocation? {
        didSet {
            loadViewIfNeeded()
            self.tableView.reloadData()
        }
    }
    var categoryLanding: String?

    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return TravelPostController.shared.savedTravelPosts.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "travelPostCell", for: indexPath) as? UsersPostsTableViewCell else { return UITableViewCell()}
        let post = TravelPostController.shared.savedTravelPosts[indexPath.row]
        cell.savedPost = post
        cell.delegate = self
        return cell
    }
    
    func cellButtonTapped(_ sender: UsersPostsTableViewCell) {
        guard let index = tableView.indexPath(for: sender) else { return }
        alertControllerToRemovePost()
    }
    
    func alertControllerToRemovePost() {
        let alertcontroller = UIAlertController(title: "Remove post?", message: "This may be a precious memory that you hold dear and would like to remember, deleting it will delete it for good and will make it so others can't see how much fun you had. Really think it through!", preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        let deleteAction = UIAlertAction(title: "Delete", style: .destructive) { (_) in
        }
        alertcontroller.addAction(cancelAction)
        alertcontroller.addAction(deleteAction)
        present(alertcontroller, animated: true)
    }
}
