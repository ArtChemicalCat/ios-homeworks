 //
//  TabBarViewController.swift
//  Navigation
//
//  Created by Николай Казанин on 02.03.2022.
//

import UIKit

enum TabBarPage {
    case feed
    case profile
    
    var pageTitle: String {
        switch self {
        case .feed:
            return "Лента"
        case .profile:
            return "Профиль"
        }
    }
    
    var image: UIImage? {
        switch self {
        case .feed:
            return UIImage(systemName: "house.circle")
        case .profile:
            return UIImage(systemName: "person.circle")
        }
    }
}

class TabBarViewController: UITabBarController {
    
    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
    }
}
