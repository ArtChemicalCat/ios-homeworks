//
//  ProfileViewController.swift
//  Navigation
//
//  Created by Николай Казанин on 02.03.2022.
//

import UIKit

class ProfileViewController: UIViewController {
    
//MARK: - Properties
    private lazy var originalAvatarPosition: CGPoint = .zero
    
//MARK: - Views
    let profileHeaderView: ProfileHeaderView = {
        let view = ProfileHeaderView()
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    let myButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Tap me!", for: .normal)
        button.configuration = .bordered()
        return button
    }()
    
    let closeButton: UIButton = {
        let button = UIButton(type: .roundedRect)
        button.setImage(UIImage(systemName: "xmark"), for: .normal)
        button.backgroundColor = .red
        button.alpha = 0
        button.addTarget(self, action: #selector(closeButtonAction), for: .touchUpInside)
        
        return button
    }()
    
//MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        layout()
        navigationController?.navigationBar.isHidden = true
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tapAction))
        profileHeaderView.profileImage.addGestureRecognizer(tapGesture)
    }
    
//MARK: - Layout
    private func layout() {
        view.backgroundColor = .lightGray
        [myButton, profileHeaderView, closeButton].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview($0)
        }
        
        NSLayoutConstraint.activate([
            profileHeaderView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            profileHeaderView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            profileHeaderView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            profileHeaderView.heightAnchor.constraint(equalToConstant: 220),
            
            myButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            myButton.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            myButton.trailingAnchor.constraint(equalTo: view.trailingAnchor),

            closeButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            closeButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16)
            
        ])
    }
    
//MARK: - Actions
    @objc private func tapAction() {
        originalAvatarPosition = profileHeaderView.profileImage.center
        let scale = UIScreen.main.bounds.width / self.profileHeaderView.profileImage.bounds.width
        UIView.animate(withDuration: 0.5) {
            self.profileHeaderView.profileImage.center = CGPoint(x: UIScreen.main.bounds.midX,
                                                                 y: UIScreen.main.bounds.midY - self.profileHeaderView.profileImage.bounds.midY)
            self.profileHeaderView.profileImage.transform = CGAffineTransform(scaleX: scale, y: scale)
            self.profileHeaderView.profileImage.layer.cornerRadius = 0
            self.profileHeaderView.semitransparentView.alpha = 0.5
        } completion: { _ in
            UIView.animate(withDuration: 0.3) {
                self.closeButton.alpha = 1
            }
        }
    }
    
    @objc private func closeButtonAction() {
        UIView.animate(withDuration: 0.3) {
            self.closeButton.alpha = 0
            
        } completion: { _ in
            UIView.animate(withDuration: 0.5) {
                self.profileHeaderView.profileImage.center = self.originalAvatarPosition
                self.profileHeaderView.profileImage.transform = CGAffineTransform(scaleX: 1, y: 1)
                self.profileHeaderView.profileImage.layer.cornerRadius = self.profileHeaderView.profileImage.bounds.midX
                self.profileHeaderView.semitransparentView.alpha = 0
            }
        }
    }
}
