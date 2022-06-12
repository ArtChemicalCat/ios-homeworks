 //
//  TabBarViewController.swift
//  Navigation
//
//  Created by Николай Казанин on 02.03.2022.
//

import UIKit

class TabBarViewController: UITabBarController {
    //MARK: - Navigation
    private lazy var profileCoordinator = ProfileCoordinator()
    private lazy var feedCoordinator = FeedCoordinator()
    
    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        
        guard let firstRouter = profileCoordinator.router as? NavigationRouter,
              let secondRouter = feedCoordinator.router as? NavigationRouter else { return }
        
        setViewControllers([firstRouter.navigationController, secondRouter.navigationController], animated: true)
    }
}
