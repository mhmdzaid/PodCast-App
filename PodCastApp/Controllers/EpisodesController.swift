//
//  EpisodesController.swift
//  PodCastApp
//
//  Created by mohamed zead on 10/7/18.
//  Copyright © 2018 zead. All rights reserved.
//

import Foundation
import UIKit

class EpisodesController : UITableViewController{
    fileprivate let cellID = "cellId"
    var Episodes = [Episode(title: "first"),
                    Episode(title: "second"),
                    Episode(title: "third")]

    
    var podCast : PodCast?{
        didSet{
            self.navigationItem.title = podCast?.trackName
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpTableView()
        
    }
    
    
    struct Episode{
        let title : String
    }
    
    //MARK:- tableView Methods
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Episodes.count
    }
    
    
    fileprivate func setUpTableView(){
        tableView.tableFooterView = UIView() //eliminates separator lines in tableView
        tableView.register(UITableViewCell.self, forCellReuseIdentifier:cellID)
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellID) else{
            return UITableViewCell()}
        cell.textLabel?.text = Episodes[indexPath.row].title
        return cell
    }
    
    
}
