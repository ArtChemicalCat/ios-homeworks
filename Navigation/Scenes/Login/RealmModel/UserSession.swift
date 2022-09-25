//
//  UserSession.swift
//  Navigation
//
//  Created by Николай Казанин on 25.09.2022.
//

import Foundation
import RealmSwift

final class UserSession: Object {
    @Persisted var email: String = ""
    @Persisted var password: String = ""
}
