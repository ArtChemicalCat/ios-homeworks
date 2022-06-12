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
    
    var router: Router
    
    private let loginInspectorFactory = MyLoginFactory()
        
    //MARK: - Initialiser
    init(router: Router) {
        self.router = router
    }
    
    //MARK: - Metods
    func showProfileVC(email: String, userService: UserService) {
        let profileVC = ProfileViewController(email: email, userService: userService)
        profileVC.coordinator = self
        router.present(profileVC, animated: true)
    }
    
    func showPhotosVC() {
        let photosVC = PhotosViewController()
        router.present(photosVC, animated: true)
    }
    
    //MARK: - Coordinator
    func present(animated: Bool) {}
}
