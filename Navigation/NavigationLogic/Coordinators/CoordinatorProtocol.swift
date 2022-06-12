//
//  CoordinatorProtocol.swift
//  Navigation
//
//  Created by Николай Казанин on 12.06.2022.
//

import Foundation

public protocol Coordinator: AnyObject {
    var router: Router { get set }
    
    func present(animated: Bool)
}

