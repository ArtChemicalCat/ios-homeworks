//
//  RouterProtocol.swift
//  Navigation
//
//  Created by Николай Казанин on 12.06.2022.
//

import UIKit

/// Вынес логику навигации в отдельный класс, наверное в рамках дз это лишнее,
/// но в более крупном приложении поможет разделить ответственность между объектами.
public protocol Router {
    func present(_ viewController: UIViewController, animated: Bool, presentationStyle: PresentationStyle)
    func present(_ viewController: UIViewController, animated: Bool)
}

extension Router {
    func present(_ viewController: UIViewController, animated: Bool) {
        present(viewController, animated: animated, presentationStyle: .navigation)
    }
}

