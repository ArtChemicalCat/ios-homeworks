//
//  FeedViewController.swift
//  Navigation
//
//  Created by Николай Казанин on 02.03.2022.
//

import UIKit

class FeedViewController: UIViewController {
    var postButton: UIButton!
    let post = Post(title: "Название поста")

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        
        let screenHeight = UIScreen.main.bounds.height
        let screenWidth = UIScreen.main.bounds.width
        postButton = UIButton(frame: CGRect(x: screenWidth * 0.2, y: screenHeight / 3, width: screenWidth * 0.6, height: 100))
        postButton.setTitle("Пост", for: .normal)
        postButton.configuration = .bordered()
        postButton.addTarget(self, action: #selector(showPost), for: .touchUpInside)
        
        view.addSubview(postButton)
    }
    
    @objc func showPost(sender: UIButton!) {
        let vc = PostViewController()
        vc.navigationItem.title = post.title
        navigationController?.pushViewController(vc, animated: true)
    }
}
