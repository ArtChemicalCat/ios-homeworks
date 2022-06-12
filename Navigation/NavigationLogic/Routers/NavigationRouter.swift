//
//  NavigationRouter.swift
//  Navigation
//
//  Created by Николай Казанин on 12.06.2022.
//

import UIKit

final class NavigationRouter: Router {
    private(set) var navigationController = UINavigationController()
    
    //MARK: - Initialiser
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    //MARK: - Router
    func present(_ viewController: UIViewController,
                 animated: Bool,
                 presentationStyle: PresentationStyle) {
        switch presentationStyle {
        case .modally:
            navigationController.viewControllers.last?.present(viewController, animated: animated)
        case .navigation:
            navigationController.pushViewController(viewController, animated: animated)
        }
    }
}
