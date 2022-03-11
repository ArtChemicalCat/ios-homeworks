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
        
        let profileViewController: UINavigationController = {
            
            let vc = UINavigationController(rootViewController: ProfileViewController())
            vc.tabBarItem.image = UIImage(systemName: "person.circle")
            vc.title = "Профиль"
            
            return vc
        }()
        
        let feedViewController: UINavigationController = {
            
            let vc = UINavigationController(rootViewController: FeedViewController())
            vc.tabBarItem.image = UIImage(systemName: "house.circle")
            vc.title = "Лента"
            
            return vc
        }()
        
        setViewControllers([profileViewController, feedViewController], animated: true)
    }

}
