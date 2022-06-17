//
//  LoginInspector.swift
//  Navigation
//
//  Created by Николай Казанин on 08.06.2022.
//

import Foundation

struct LoginInspector: LogInViewControllerDelegate {
    func check(password: String, forLogin login: String) -> Bool {
        PasswordValidator.shared.isPasswordValid(password, for: login)
    }
}
