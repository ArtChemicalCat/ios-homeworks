//
//  FeedViewController.swift
//  Navigation
//
//  Created by Николай Казанин on 02.03.2022.
//

import UIKit
import StorageService

class FeedViewController: UIViewController {
    
    let post = Post(author: "", description: "", image: "", likes: 0, views: 0)
    
    lazy var firstButton: CustomButton = {
        let button = CustomButton(with: "Пост") { [unowned self] in
            showPost()
        }
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    lazy var secondButton: CustomButton = {
        let button = CustomButton(with: "Пост") { [unowned self] in
            showPost()
        }
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 10
        
        return stackView
    }()


    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Лента"
        layout()
    }
    
    private func layout() {
        view.backgroundColor = .systemBackground
        view.addSubview(stackView)
        stackView.addArrangedSubview(firstButton)
        stackView.addArrangedSubview(secondButton)
        
        NSLayoutConstraint.activate([
            stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            stackView.widthAnchor.constraint(equalToConstant: 150)
        ])
    }
    
    func showPost() {
        let vc = PostViewController()
        vc.navigationItem.title = "Пост"
        navigationController?.pushViewController(vc, animated: true)
    }
}
