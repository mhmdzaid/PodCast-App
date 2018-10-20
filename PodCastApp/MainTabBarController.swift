//
//  MainTabBarController.swift
//  PodCastApp
//
//  Created by mohamed zead on 10/3/18.
//  Copyright © 2018 zead. All rights reserved.
//

import UIKit

class MainTabBarController : UITabBarController{
    
    
    var maximzePlayerDetailsConstraint : NSLayoutConstraint!
    var minimizePlayerDetailsConstraint :NSLayoutConstraint!
    var bottomPlayerDetailsConstraint : NSLayoutConstraint!
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpMainTapBarController()
        setUpPlayerDetails()
    }
    
    let playerDetailView = PlayerAudioDetail.initFromNib()
    
    fileprivate func setUpPlayerDetails() {
        
        self.view.insertSubview(playerDetailView, belowSubview: tabBar)
        playerDetailView.translatesAutoresizingMaskIntoConstraints = false
        
        maximzePlayerDetailsConstraint = playerDetailView.topAnchor.constraint(equalTo: view.topAnchor, constant: view.frame.height)
        maximzePlayerDetailsConstraint.isActive = true
        bottomPlayerDetailsConstraint =  playerDetailView.bottomAnchor.constraint(equalTo: view.bottomAnchor,constant: view.frame.height)
        bottomPlayerDetailsConstraint.isActive = true
        minimizePlayerDetailsConstraint = playerDetailView.topAnchor.constraint(equalTo: tabBar.topAnchor, constant: -64)
        //minimizePlayerDetailsConstraint.isActive = true
        playerDetailView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        playerDetailView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
    }
    
    
    @objc func minimizePlayerDetails(){
        maximzePlayerDetailsConstraint.isActive = false
        minimizePlayerDetailsConstraint.isActive = true
        bottomPlayerDetailsConstraint.constant = view.frame.height
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            self.view.layoutIfNeeded()
            self.tabBar.transform = .identity
            self.playerDetailView.miniPlayerView.alpha = 1
            self.playerDetailView.mainStackForAllContents.alpha = 0
        })
    }
    
     func maximizePlayerDetails(episode : Episode?){
        minimizePlayerDetailsConstraint.isActive = false
        maximzePlayerDetailsConstraint.isActive = true
        maximzePlayerDetailsConstraint.constant = 0
        bottomPlayerDetailsConstraint.constant = 0
        if episode != nil{
            playerDetailView.episodeToPlay = episode
        }
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            self.view.layoutIfNeeded()
            self.tabBar.transform = CGAffineTransform(translationX: 0, y: 100)
            self.playerDetailView.miniPlayerView.alpha = 0
            self.playerDetailView.mainStackForAllContents.alpha = 1
            self.playerDetailView.mainStackForAllContents.transform = .identity
        })
    }
    
    
    
    fileprivate func setUpMainTapBarController(){
        
        tabBar.tintColor = .purple
        UINavigationBar.appearance().prefersLargeTitles = true
        let favoritesController = generateNavController(with : ViewController(), title: "favorite", image: #imageLiteral(resourceName: "favorites"))
        
        let searchNavController = generateNavController(with: podCastSearchController(), title:"search" , image: #imageLiteral(resourceName: "search"))
        
        
        let DownloadNavController = generateNavController(with : ViewController(), title: "Downloads", image: #imageLiteral(resourceName: "downloads"))
        
        
        self.viewControllers = [favoritesController , searchNavController , DownloadNavController ]
        
    }
    
    //MARK:- help functions
    fileprivate func generateNavController(with rootViewController : UIViewController , title : String,image : UIImage)->UIViewController{
        let NavController = UINavigationController(rootViewController: rootViewController)
        rootViewController.navigationItem.title = title
        NavController.tabBarItem.title = title
        NavController.tabBarItem.image = image
        return NavController
    }
}
