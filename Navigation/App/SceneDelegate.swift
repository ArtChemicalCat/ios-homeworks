//
//  SceneDelegate.swift
//  Navigation
//
//  Created by Николай Казанин on 27.02.2022.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    private lazy var router = SceneDelegateRouter(window: window!)
    private lazy var coordinator = MainCoordinator(router: router)

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        self.window = UIWindow(windowScene: windowScene)
        coordinator.present(animated: false)
        NetworkManager.request(AppConfiguration.allCases.randomElement()!)
    }
}

