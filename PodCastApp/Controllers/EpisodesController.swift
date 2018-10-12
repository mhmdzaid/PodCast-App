//
//  EpisodesController.swift
//  PodCastApp
//
//  Created by mohamed zead on 10/7/18.
//  Copyright © 2018 zead. All rights reserved.
//

import Foundation
import UIKit
import FeedKit
class EpisodesController : UITableViewController{
    
    fileprivate let cellID = "cellId"
    var Episodes = [Episode]()
    var podCast : PodCast?{
        didSet{
            self.navigationItem.title = podCast?.trackName
            fetchEpisodes()
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpTableView()
    }
    
    
    
    //MARK:- Networking
    
    
    fileprivate func fetchEpisodes(){
    
        guard var feedURLString = podCast?.feedUrl else{return}
        feedURLString = feedURLString.toHTTPSecured()  //replacing Http with Https
        APIService.shared.fetchEpisodes(url: feedURLString) { (returnedEpisodes) in
            self.Episodes = returnedEpisodes
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
       
    }
    
    //MARK:- tableView Methods
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let activityIndicator = UIActivityIndicatorView(activityIndicatorStyle: .whiteLarge)
        activityIndicator.color = UIColor.gray
        activityIndicator.startAnimating()
        return activityIndicator
    }
    override func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
       tableView.tableFooterView = UIView()
        let label = UILabel()
        label.text = "Loading ... "
        label.font = UIFont.systemFont(ofSize: 19, weight: .semibold)
        label.textColor = .purple
        label.textAlignment = .center
        return label
    }
    
    
    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return self.Episodes.isEmpty ? 90: 0
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return Episodes.isEmpty ? 70 : 0
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let episode = self.Episodes[indexPath.row]
        let playerDetailController = UIApplication.shared.keyWindow?.rootViewController as! MainTabBarController
          playerDetailController.maximizePlayerDetails(episode: episode)
//
//        let window = UIApplication.shared.keyWindow
//        let playerDetailView = PlayerAudioDetail.initFromNib()
//        playerDetailView.episodeToPlay = episode
//        playerDetailView.frame = self.view.frame
//        window?.addSubview(playerDetailView)
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Episodes.count
    }
    
    
    
    fileprivate func setUpTableView(){
        tableView.tableFooterView = UIView() //eliminates separator lines in tableView
        let nib = UINib(nibName: "EpisodeCellTableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: cellID)
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellID) as? EpisodeCellTableViewCell
            else{
            return UITableViewCell()
        }
        let episode = Episodes[indexPath.row]
        cell.episode = episode
        return cell
    }
    
   override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 134
    }
    
    
}
