//
//  ProfileViewController.swift
//  Navigation
//
//  Created by Николай Казанин on 02.03.2022.
//

import UIKit

class ProfileViewController: UIViewController {
    
    let profileHeaderView = ProfileHeaderView()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .lightGray
        
        
    }
    
    override func viewWillLayoutSubviews() {
        view.addSubview(profileHeaderView)
        let rect = view.bounds.inset(by: view.safeAreaInsets)
        profileHeaderView.frame = rect
    }
    
}
