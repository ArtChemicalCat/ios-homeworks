 //
//  TabBarViewController.swift
//  Navigation
//
//  Created by Николай Казанин on 02.03.2022.
//

import UIKit

class TabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .red
        
        let profileViewController = UINavigationController(rootViewController: ProfileViewController())
        let feedViewController = UINavigationController(rootViewController: FeedViewController())
        
        profileViewController.tabBarItem.image = UIImage(systemName: "person.circle")
        feedViewController.tabBarItem.image = UIImage(systemName: "house.circle")
        profileViewController.navigationItem.title = "Title"
        
        profileViewController.title = "Профиль"
        feedViewController.title = "Лента"
        
        setViewControllers([profileViewController,
                            feedViewController],
                           animated: true)
    }

}
