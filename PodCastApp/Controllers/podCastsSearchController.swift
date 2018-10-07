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
    
    var podCasts = [PodCast]()
    
    let cellID = "cellID"
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
         setUpSearchController()
         setUpTableView()
    }
    
 
    fileprivate func setUpSearchController(){
        let searchController = UISearchController(searchResultsController: nil)
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        searchController.searchBar.delegate = self
        searchController.dimsBackgroundDuringPresentation = false
    }
    
    
    fileprivate func setUpTableView(){
        let nib = UINib(nibName: "PodCastCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: cellID)
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
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        tableView.tableFooterView = UIView()
        let label = UILabel()
        label.text = "What you are searching for ?"
        label.font = UIFont.systemFont(ofSize: 19, weight: .semibold)
        label.textColor = UIColor.purple
        label.textAlignment = .center
        return label
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 250
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return podCasts.count
    }
    override func numberOfSections(in tableView: UITableView) -> Int {
       return 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath) as? podCastTableViewCell else{return UITableViewCell()}
        cell.podcast = podCasts[indexPath.row]
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 130
    }
}
