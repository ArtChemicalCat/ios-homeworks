//
//  ProfileHeaderView.swift
//  Navigation
//
//  Created by Николай Казанин on 11.03.2022.
//

import UIKit
import Combine

class ProfileHeaderView: UITableViewHeaderFooterView {
    
    private var statusText = ""
    var subscription = Set<AnyCancellable>()

    let profileImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "headImage")
        image.layer.borderWidth = 3
        image.layer.borderColor = UIColor.white.cgColor
        image.layer.cornerRadius = 75
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
    
    lazy var statusButton: UIButton = {
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
    
    lazy var statusTextField: UITextField = {
        let textField = UITextField()
        textField.backgroundColor = .white
        
        textField.layer.borderWidth = 1
        textField.layer.borderColor = UIColor.black.cgColor
        textField.layer.cornerRadius = 12
        textField.textAlignment = .center
        textField.font = .systemFont(ofSize: 15, weight: .regular)
        textField.textColor = .black
        textField.delegate = self
        textField.addTarget(self, action: #selector(statusTextChanged), for: .editingChanged)

        return textField
    }()
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        
        let views = [profileImage, nameLabel, statusButton, statusLabel, statusTextField]
        
        views.forEach({ contentView.addSubview($0) })
        views.forEach({ $0.translatesAutoresizingMaskIntoConstraints = false })

        NSLayoutConstraint.activate([
            profileImage.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            profileImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            profileImage.widthAnchor.constraint(equalToConstant: 150),
            profileImage.heightAnchor.constraint(equalToConstant: 150),

            nameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 27),
            nameLabel.leadingAnchor.constraint(equalTo: profileImage.trailingAnchor, constant: 20),
        
            statusButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            statusButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            statusButton.topAnchor.constraint(equalTo: statusTextField.bottomAnchor, constant: 16),
            statusButton.heightAnchor.constraint(equalToConstant: 50),
        
            statusLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 50),
            statusLabel.leadingAnchor.constraint(equalTo: profileImage.trailingAnchor, constant: 20),
        
            statusTextField.topAnchor.constraint(equalTo: statusLabel.bottomAnchor, constant: 16),
            statusTextField.leadingAnchor.constraint(equalTo: profileImage.trailingAnchor, constant: 20),
            statusTextField.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            statusTextField.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc
    private func tapAction() {

        guard let text = statusTextField.text, !text.isEmpty else { return }
        print(statusText)
        statusLabel.text = statusText
    }
    
    @objc
    private func statusTextChanged(_ textField: UITextField) {
        if let text = textField.text {
            statusText = text
        }
    }
    
}

extension ProfileHeaderView: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        tapAction()
        self.endEditing(true)
        return true
    }
}
