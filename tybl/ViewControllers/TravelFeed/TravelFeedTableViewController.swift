//
//  TravelFeedTableViewController.swift
//  tybl
//
//  Created by Nathan Andrus on 3/27/19.
//  Copyright © 2019 Nathan Andrus. All rights reserved.
//

import UIKit

class TravelFeedTableViewController: UITableViewController {

    //MARK: - Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.reloadData()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        TravelPostController.shared.fetchAllPosts { (success) in
            if success {
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
    }

    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return TravelPostController.shared.travelPostsForFeed.count
    }
    
    override func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 600
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 600
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "travelPostCell", for: indexPath) as? TravelPostTableViewCell
        let post = TravelPostController.shared.travelPostsForFeed[indexPath.row]
        TravelPostController.shared.fetchImagesForPost(post: post) { (success) in
            
        }
        cell?.postLanding = post
        return cell ?? UITableViewCell()
    }

    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
}
