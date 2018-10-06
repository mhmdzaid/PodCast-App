//
//  podCastsSearchController.swift
//  PodCastApp
//
//  Created by mohamed zead on 10/3/18.
//  Copyright © 2018 zead. All rights reserved.
//

import UIKit
import Alamofire
class podCastSearchController : UITableViewController,UISearchBarDelegate{
    
    var podCasts = [PodCast(name : "behind the zone",artistName : "Moahemd Zead"),
                    PodCast(name : "on the fire",artistName : "Michel jole")]
    
    let cellID = "cellID"
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
         setUpSearchController()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellID)
    }
    
    fileprivate func setUpSearchController(){
        let searchController = UISearchController(searchResultsController: nil)
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        searchController.searchBar.delegate = self
        searchController.dimsBackgroundDuringPresentation = false
    }
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        print(searchText)
        //Implementing Alamofire to get podcasts from the API
        APIService.shared.fetchPodCasts(searchText: searchText) { (returnedPodCasts) in
            self.podCasts = returnedPodCasts
            self.tableView.reloadData()
        }
   
    }
    
   
    
    //MARK:- tableView Methods
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return podCasts.count
    }
    override func numberOfSections(in tableView: UITableView) -> Int {
       return 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath)
        let podCast = podCasts[indexPath.row]
        cell.textLabel?.numberOfLines = -1 //inifinty number of lines
        cell.textLabel?.text = "\(podCast.trackName)\n \(podCast.artistName)"
        cell.imageView?.image = #imageLiteral(resourceName: "appicon")
        return cell
    }
    
}
