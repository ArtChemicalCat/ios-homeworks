//
//  LoginFactory.swift
//  Navigation
//
//  Created by Николай Казанин on 08.06.2022.
//

import Foundation

import Foundation

protocol LoginFactory {
    func makeLoginInspector() -> LoginInspector
}

final class MyLoginFactory: LoginFactory {
    func makeLoginInspector() -> LoginInspector {
        LoginInspector()
    }
}
