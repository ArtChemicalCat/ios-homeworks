//
//  FeedCoordinator.swift
//  Navigation
//
//  Created by Николай Казанин on 12.06.2022.
//

import UIKit

final class FeedCoordinator: Coordinator {
    var router: Router
    
    init() {
        let model = FeedModel()
        let feedVC = FeedViewController(model: model)
        let navigationVC = UINavigationController(rootViewController: feedVC)
        navigationVC.tabBarItem.image = UIImage(systemName: "house.circle")
        navigationVC.title = "Лента"
        self.router = NavigationRouter(navigationController: navigationVC)
        feedVC.coordinator = self
    }
    
    //MARK: - Metods
    func showPostVC() {
        let postVC = PostViewController()
        postVC.coordinator = self
        router.present(postVC, animated: true)
    }
    
    func showInfoVC() {
        let infoVC = InfoViewController()
        router.present(infoVC, animated: true, presentationStyle: .modally)
    }
    
    //MARK: - Coordinator
    func present(animated: Bool) { }
}
