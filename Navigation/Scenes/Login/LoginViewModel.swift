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
    private let passwordGenerator = PasswordHacker()
    
    @Published var errorMessage: String?
    @Published var isGeneratingPassword = false
    @Published var unlockedPassword: String?
    
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
    
    func hackPassword() {
        let randomGeneratedPassword = generatePassword(length: 3)
        
        PasswordValidator.shared.setNewPassword(randomGeneratedPassword)
        
        isGeneratingPassword = true
        DispatchQueue.global(qos: .userInitiated).async { [weak self] in
            var password: String = ""
            guard let self = self else { return }
            
            while password != randomGeneratedPassword {
                password = self.passwordGenerator
                    .generateBruteForce(password, fromArray: String.printable.map { String($0) })
                print(password)
            }
            
            DispatchQueue.main.async {
                self.isGeneratingPassword = false
                self.unlockedPassword = password
            }
            
        }
        
    }
    
    private func generatePassword(length: Int) -> String {
        var password = ""
        (0..<length).forEach { _ in
            password.append(String.printable.randomElement() ?? "a")
        }
        return password
    }
}
