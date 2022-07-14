//
//  User.swift
//  StorageService
//
//  Created by Николай Казанин on 04.06.2022.
//

import UIKit

public final class User {
    public let fullName: String
    public let email: String
    public let status: String
    public let avatarImage: UIImage?
    
    public init(fullName: String,
                email: String,
                status: String = "",
                avatarImage: UIImage? = UIImage(systemName: "person.crop.circle")) {
        self.fullName = fullName
        self.email = email
        self.status = status
        self.avatarImage = avatarImage
    }
}
