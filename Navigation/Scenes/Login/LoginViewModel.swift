//
//  LoginViewModel.swift
//  Navigation
//
//  Created by Николай Казанин on 12.06.2022.
//

import Foundation
import StorageService

final class LoginViewModel {
    private let loginInspector: LoginInspector
    private weak var coordinator: ProfileCoordinator!
    
    @Published var errorMessage: String?
    
    init(loginFactory: LoginFactory, coordinator: ProfileCoordinator) {
        self.loginInspector = loginFactory.makeLoginInspector()
        self.coordinator = coordinator
    }
    
    func login(email: String, password: String) {
        guard loginInspector.check(password: password, forLogin: email) else {
            errorMessage = "Неверный логин и/или пароль"
            return
        }
        
        coordinator.showProfileVC(email: email)
    }
}
