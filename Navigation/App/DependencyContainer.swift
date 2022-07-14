//
//  DependencyContainer.swift
//  Navigation
//
//  Created by Николай Казанин on 12.06.2022.
//

import Foundation
import StorageService

final class DependencyContainer {
    var userService: UserService {
        #if DEBUG
        return TestUserService()
        #else
        return CurrentUserService()
        #endif
    }
    
    func makeFeedViewController(coordinator: FeedCoordinator) -> FeedViewController {
        let model = FeedModel()
        let feedVC = FeedViewController(model: model)
        feedVC.coordinator = coordinator
        return feedVC
    }
    
    func makeProfileViewController(email: String, coordinator: ProfileCoordinator) -> ProfileViewController {
        let profileVC = ProfileViewController(email: email, userService: userService)
        profileVC.coordinator = coordinator
        return profileVC
    }
    
    func makeLoginViewController(coordinator: ProfileCoordinator) -> LogInViewController {
        let viewModel = LoginViewModel(loginFactory: self, coordinator: coordinator)
        return LogInViewController(viewModel: viewModel)
    }
}
