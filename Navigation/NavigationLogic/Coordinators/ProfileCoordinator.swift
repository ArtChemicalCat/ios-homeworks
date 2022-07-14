//
//  ProfileCoordinator.swift
//  Navigation
//
//  Created by Николай Казанин on 12.06.2022.
//

import UIKit
import StorageService

final class ProfileCoordinator: Coordinator {
    //MARK: - Properties
    var children: [Coordinator] = []
    let router: Router
    
    private let dependencyContainer: DependencyContainer
        
    //MARK: - Initialiser
    init(router: Router, dependencyContainer: DependencyContainer) {
        self.router = router
        self.dependencyContainer = dependencyContainer
    }
    
    //MARK: - Metods
    func showProfileVC(email: String) {
        let profileVC = dependencyContainer.makeProfileViewController(email: email, coordinator: self)
        
        router.present(profileVC, animated: true)
    }
    
    func showPhotosVC() {
        let photosVC = PhotosViewController()
        router.present(photosVC, animated: true)
    }
    
    //MARK: - Coordinator
    func present(animated: Bool) {}
}
