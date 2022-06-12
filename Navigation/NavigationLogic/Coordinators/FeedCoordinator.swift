//
//  FeedCoordinator.swift
//  Navigation
//
//  Created by Николай Казанин on 12.06.2022.
//

import UIKit

final class FeedCoordinator: Coordinator {
    //MARK: - Properties
    var children: [Coordinator] = []
    
    var router: Router
    
    //MARK: - Initialiser
    init(router: Router) {
        self.router = router
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
