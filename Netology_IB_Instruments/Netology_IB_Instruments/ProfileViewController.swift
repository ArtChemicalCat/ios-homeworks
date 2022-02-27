//
//  ProfileViewController.swift
//  Netology_IB_Instruments
//
//  Created by Николай Казанин on 27.02.2022.
//

import UIKit

class ProfileViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let screenWidth = UIScreen.main.bounds.width
        let screenHeight = UIScreen.main.bounds.height
        
        if let profileView = Bundle.main.loadNibNamed("ProfileView", owner: nil, options: nil)?.first as? ProfileView {
            profileView.frame = CGRect(x: 10, y: screenHeight * 0.1, width: screenWidth - 20, height: screenHeight * 0.8)
            view.addSubview(profileView)
        }
    }
    



}
