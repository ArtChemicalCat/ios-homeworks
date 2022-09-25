//
//  LoginViewModel.swift
//  Navigation
//
//  Created by Николай Казанин on 12.06.2022.
//

import Foundation
import StorageService
import FirebaseAuth

final class LoginViewModel {
    private let loginInspector: LoginInspector
    private weak var coordinator: ProfileCoordinator!
    
    @Published var isLoginButtonEnabled = false
    @Published var errorMessage: String?
    
    init(loginFactory: LoginFactory, coordinator: ProfileCoordinator) {
        self.loginInspector = loginFactory.makeLoginInspector()
        self.coordinator = coordinator
    }
}

extension LoginViewModel: CheckerServiceProtocol {
    func checkCredentials(email: String, password: String) {
        FirebaseAuth.Auth.auth().signIn(
            withEmail: email, password: password
        ) { [weak self] result, error in
            if let error = error {
                self?.errorMessage = error.localizedDescription
            }
            guard result != nil else { return }
            self?.coordinator.showProfileVC(email: email)
        }
    }
    
    func signUp(email: String, password: String) {
        FirebaseAuth.Auth.auth().createUser(
            withEmail: email, password: password
        ) { [weak self] result, error in
            if let error = error {
                self?.errorMessage = error.localizedDescription
            }
            guard result != nil else { return }
            self?.coordinator.showProfileVC(email: email)
        }
    }
}
