//
//  MainTabBarController.swift
//  PodCastApp
//
//  Created by mohamed zead on 10/3/18.
//  Copyright © 2018 zead. All rights reserved.
//

import UIKit

class MainTabBarController : UITabBarController{
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
