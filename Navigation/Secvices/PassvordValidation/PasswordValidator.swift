//
//  PasswordValidator.swift
//  Navigation
//
//  Created by Николай Казанин on 08.06.2022.
//

import Foundation

public final class PasswordValidator {
    private let login = "artchemist@yandex.ru"
    private var password = "qwerty123"
    
    public static let shared = PasswordValidator()
    
    private init() {}
    
    public func isPasswordValid(_ password: String, for login: String) -> Bool {
        return self.login == login.lowercased() && self.password.hash == password.hash
    }
    
    public func setNewPassword(_ password: String) {
        self.password = password
    }
}

