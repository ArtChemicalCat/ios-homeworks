//
//  UserService.swift
//  StorageService
//
//  Created by Николай Казанин on 04.06.2022.
//

import Foundation
import UIKit

public protocol UserService {
    func getUser(with email: String) -> User?
}

public final class CurrentUserService: UserService {
    private let currentUser: User
    
    public init(user: User = User(fullName: "Николай Казанин", email: "artchemist@yandex.ru", avatarImage: UIImage(named: "headImage"))) {
        self.currentUser = user
    }
    
    public func getUser(with email: String) -> User? {
        guard currentUser.email == email else { return nil}
        return currentUser
    }
}

public final class TestUserService: UserService {
    private let testUser: User
    
    public init(user: User = User(fullName: "Тестовый пользователь", email: "123@mail.com", status: "Тестовый статус")) {
        self.testUser = user
    }
    
    public func getUser(with email: String) -> User? {
        guard testUser.email == email else { return nil }
        return testUser
    }
}
