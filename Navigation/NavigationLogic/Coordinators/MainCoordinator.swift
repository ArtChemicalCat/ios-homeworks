//
//  MainCoordinator.swift
//  Navigation
//
//  Created by Николай Казанин on 12.06.2022.
//

import UIKit

enum TabBarPage {
    case feed
    case profile
    
    var pageTitle: String {
        switch self {
        case .feed:
            return "Лента"
        case .profile:
            return "Профиль"
        }
    }
    
    var image: UIImage? {
        switch self {
        case .feed:
            return UIImage(systemName: "house.circle")
        case .profile:
            return UIImage(systemName: "person.circle")
        }
    }
}


final class MainCoordinator: Coordinator {
    var children: [Coordinator] = []
    let router: Router
    
    private let dependencyContainer = DependencyContainer()
    
    //MARK: - Initialiser
    init(router: Router) {
        self.router = router
    }
    
    //MARK: - Coordinator
    func present(animated: Bool) {
        let tabBarVC = TabBarViewController()
        let pages: [TabBarPage] = [.profile, .feed]
        
        tabBarVC.setViewControllers(pages.map { getTabController(page: $0) }, animated: animated)
        
        router.present(tabBarVC, animated: animated)
    }
    
    //MARK: - Metods
    private func getTabController(page: TabBarPage) -> UINavigationController {
        let navigationVC = UINavigationController()
        navigationVC.tabBarItem.image = page.image
        navigationVC.tabBarItem.title = page.pageTitle

        
        switch page {
        case .feed:
            let navigationRouter = NavigationRouter(navigationController: navigationVC)
            let feedCoordinator = FeedCoordinator(router: navigationRouter)
            let feedVC = dependencyContainer.makeFeedViewController(coordinator: feedCoordinator)
            
            navigationVC.pushViewController(feedVC, animated: true)
            children.append(feedCoordinator)
                        
        case .profile:
            let navigationRouter = NavigationRouter(navigationController: navigationVC)
            let profileCoordinator = ProfileCoordinator(router: navigationRouter,
                                                        dependencyContainer: dependencyContainer)
            let loginVC = dependencyContainer.makeLoginViewController(coordinator: profileCoordinator)

            navigationVC.pushViewController(loginVC, animated: true)
            children.append(profileCoordinator)
        }
        
        return navigationVC
    }
}
