//
//  ExploreTableViewController.swift
//  tybl
//
//  Created by Nathan Andrus on 4/3/19.
//  Copyright © 2019 Nathan Andrus. All rights reserved.
//

import UIKit

class ExploreTableViewController: UITableViewController {
    
    //MARK: - Outlets
    @IBOutlet weak var exploreSearchBar: UISearchBar!
    @IBOutlet weak var addLocationButton: UIButton!
    
    //MARK: - Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    //MARK: - IBActions
    @IBAction func addLocationButtonTapped(_ sender: UIButton) {
        addLocationAlertController()
    }
    
    //MARK: - Helper Functions
    func addLocationAlertController() {
        let alertController = UIAlertController(title: "Add new location?", message: "Adding this location to Bucket List will enable you to see posts on your main feed from this location and begin to plan your trip there!", preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        let addAction = UIAlertAction(title: "Let's do this", style: .default) { (_) in
        }
        alertController.addAction(cancelAction)
        alertController.addAction(addAction)
        self.present(alertController, animated: true)
    }
    
    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return TravelPostController.shared.searchResultsPosts.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "searchCell", for: indexPath) as? SearchResultsTableViewCell else { return UITableViewCell()}
        let searchPost = TravelPostController.shared.searchResultsPosts[indexPath.row]
        cell.postLanding = searchPost
        return cell
    }
}

//MARK: - SearchBar Extension
extension ExploreTableViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
//        BucketListLocationController.shared.fetchLocations()
    }
}
