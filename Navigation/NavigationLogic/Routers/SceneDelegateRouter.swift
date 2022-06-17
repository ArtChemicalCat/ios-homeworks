//
//  SceneDelegateRouter.swift
//  Navigation
//
//  Created by Николай Казанин on 12.06.2022.
//

import UIKit

final class SceneDelegateRouter: Router {
    private let window: UIWindow
    
    init(window: UIWindow) {
        self.window = window
    }
    
    func present(_ viewController: UIViewController,
                 animated: Bool,
                 presentationStyle: PresentationStyle) {
        window.rootViewController = viewController
        window.makeKeyAndVisible()
    }
}
