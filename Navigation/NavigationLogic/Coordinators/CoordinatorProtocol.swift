//
//  CoordinatorProtocol.swift
//  Navigation
//
//  Created by Николай Казанин on 12.06.2022.
//

import Foundation

public protocol Coordinator: AnyObject {
    var children: [Coordinator] { get set }
    
    var router: Router { get set }
    
    func present(animated: Bool)
}

