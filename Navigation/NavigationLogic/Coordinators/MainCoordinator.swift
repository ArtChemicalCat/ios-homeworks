//
//  MainCoordinator.swift
//  Navigation
//
//  Created by Николай Казанин on 12.06.2022.
//

import UIKit

final class MainCoordinator: Coordinator {
    var children: [Coordinator] = []
    
    var router: Router
    
    //MARK: - Initialiser
    init(router: Router) {
        self.router = router
    }
    
    //MARK: - Coordinator
    func present(animated: Bool) {
        let tabBarVC = TabBarViewController()
        let pages: [TabBarPage] = [.feed, .profile]
        
        tabBarVC.setViewControllers(pages.map { getTabController(page: $0) }, animated: true)
        
        router.present(tabBarVC, animated: animated)
    }
    
    //MARK: - Metods
    private func getTabController(page: TabBarPage) -> UINavigationController {
        let navigationVC = UINavigationController()
        navigationVC.tabBarItem.image = page.image
        navigationVC.title = page.pageTitle

        
        switch page {
        case .feed:
            let feedVC = FeedViewController(model: FeedModel())
            navigationVC.pushViewController(feedVC, animated: true)
            let navigationRouter = NavigationRouter(navigationController: navigationVC)
            let feedCoordinator = FeedCoordinator(router: navigationRouter)
            children.append(feedCoordinator)
            
            feedVC.coordinator = feedCoordinator
            
        case .profile:
            let loginVC = LogInViewController()
            loginVC.delegate = MyLoginFactory().makeLoginInspector()
            navigationVC.pushViewController(loginVC, animated: true)
            let navigationRouter = NavigationRouter(navigationController: navigationVC)
            let profileCoordinator = ProfileCoordinator(router: navigationRouter)
            children.append(profileCoordinator)
            
            loginVC.coordinator = profileCoordinator
        }
        
        return navigationVC
    }
}
