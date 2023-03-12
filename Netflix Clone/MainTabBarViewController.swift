//
//  ViewController.swift
//  Netflix Clone
//
//  Created by AyechanMaung on 11/03/2023.
//

import UIKit

class MainTabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemYellow
        // Assign controllers
    
        let homeVC = UINavigationController(rootViewController: HomeViewController())
        let upcomingVC = UINavigationController(rootViewController: UpcomingViewController())
        let searchVC = UINavigationController(rootViewController: SearchViewController())
        let downloadVC = UINavigationController(rootViewController: DownloadsViewController())
        
        // Set Tab Item
        homeVC.tabBarItem.image = UIImage(systemName: "house")
        upcomingVC.tabBarItem.image = UIImage(systemName: "play.circle")
        searchVC.tabBarItem.image = UIImage(systemName: "magnifyingglass")
        downloadVC.tabBarItem.image = UIImage(systemName: "arrow.down.to.line")
        
        // Set Tab Title
        homeVC.title = "Home"
        upcomingVC.title = "Comming Soon"
        searchVC.title = "Top Search"
        downloadVC.title = "Downloads"
        
        tabBar.tintColor = .label
        
        // Set View Controllers
        setViewControllers([homeVC, upcomingVC, searchVC, downloadVC], animated: true)
    }


}

