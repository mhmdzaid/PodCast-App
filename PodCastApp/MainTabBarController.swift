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
        minimizePlayerDetailsConstraint = playerDetailView.topAnchor.constraint(equalTo: tabBar.topAnchor, constant: -64)
        //minimizePlayerDetailsConstraint.isActive = true
        playerDetailView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        playerDetailView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        playerDetailView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
       
    }
    
    
    @objc func minimizePlayerDetails(){
        maximzePlayerDetailsConstraint.isActive = false
        minimizePlayerDetailsConstraint.isActive = true
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            self.view.layoutIfNeeded()
            self.tabBar.transform = .identity
        })
    }
    
     func maximizePlayerDetails(episode : Episode?){
        maximzePlayerDetailsConstraint.isActive = true
        maximzePlayerDetailsConstraint.constant = 0
        minimizePlayerDetailsConstraint.isActive = false
        if episode != nil{
            playerDetailView.episodeToPlay = episode
        }
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            self.view.layoutIfNeeded()
            self.tabBar.transform = CGAffineTransform(translationX: 0, y: 100)
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
