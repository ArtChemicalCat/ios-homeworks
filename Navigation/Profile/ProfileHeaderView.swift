//
//  ProfileHeaderView.swift
//  Navigation
//
//  Created by Николай Казанин on 11.03.2022.
//

import UIKit

class ProfileHeaderView: UIView {

    let profileImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "headImage")
        image.layer.borderWidth = 3
        image.layer.borderColor = UIColor.white.cgColor
        image.layer.cornerRadius = UIScreen.main.bounds.width * 0.17
        image.clipsToBounds = true
        
        return image
    }()
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.text = "Иван Иванов"
        label.font = .systemFont(ofSize: 18, weight: .bold)
        label.textColor = .black
        return label
    }()
    
    let statusButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .systemBlue
        button.layer.cornerRadius = 4
        button.setTitle("Show status", for: .normal)
        
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowRadius = 4
        button.layer.shadowOpacity = 0.7
        button.layer.shadowOffset = CGSize(width: 4, height: 4)
        button.addTarget(self, action: #selector(tapAction), for: .touchUpInside)
        
        return button
    }()
    
    let statusLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14, weight: .regular)
        label.text = "Waiting for something..."
        label.textColor = .gray
        
        return label
    }()
    
    init() {
        super.init(frame: .zero)
        
        let screenSize = UIScreen.main.bounds
        let views = [profileImage, nameLabel, statusButton, statusLabel]
        
        views.forEach({ addSubview($0) })
        views.forEach({ $0.translatesAutoresizingMaskIntoConstraints = false })
        
        NSLayoutConstraint.activate([
            profileImage.topAnchor.constraint(equalTo: self.topAnchor, constant: 16),
            profileImage.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            profileImage.widthAnchor.constraint(equalToConstant: screenSize.width * 0.34),
            profileImage.heightAnchor.constraint(equalToConstant: screenSize.width * 0.34)
        ])

        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 27),
            nameLabel.leadingAnchor.constraint(equalTo: profileImage.trailingAnchor, constant: 20)
        ])
        
        NSLayoutConstraint.activate([
            statusButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            statusButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
            statusButton.topAnchor.constraint(equalTo: profileImage.bottomAnchor, constant: 16),
            statusButton.heightAnchor.constraint(equalToConstant: 50)
        ])
        
        NSLayoutConstraint.activate([
            statusLabel.bottomAnchor.constraint(equalTo: statusButton.topAnchor, constant: -34),
            statusLabel.leadingAnchor.constraint(equalTo: profileImage.trailingAnchor, constant: 20)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc
    private func tapAction() {
        if let status = statusLabel.text {
            print(status)
        } else {
            print("status is empty")
        }
    }
    
}
