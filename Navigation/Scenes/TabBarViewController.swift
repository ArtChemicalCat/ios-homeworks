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
        view.backgroundColor = .systemBackground
                
        let logInViewController: UINavigationController = {
            let vc = UINavigationController(rootViewController: LogInViewController())
            vc.tabBarItem.image = UIImage(systemName: "person.circle")
            vc.title = "Профиль"
            
            return vc
        }()
        
        let feedViewController: UINavigationController = {
            
            let vc = UINavigationController(rootViewController: FeedViewController(model: FeedModel()))
            vc.tabBarItem.image = UIImage(systemName: "house.circle")
            vc.title = "Лента"
            
            return vc
        }()
        
        setViewControllers([feedViewController, logInViewController], animated: true)
        tabBar.isTranslucent = false
    }

}
