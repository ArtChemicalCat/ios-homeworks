//
//  CheckerServiceProtocol.swift
//  Navigation
//
//  Created by Николай Казанин on 15.08.2022.
//

import Foundation

protocol CheckerServiceProtocol {
    func checkCredentials(email: String, password: String)
    func signUp(email: String, password: String)
}
