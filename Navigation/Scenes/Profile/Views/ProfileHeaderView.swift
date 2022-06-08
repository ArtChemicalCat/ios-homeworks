//
//  ProfileHeaderView.swift
//  Navigation
//
//  Created by Николай Казанин on 11.03.2022.
//

import UIKit
import SnapKit
import Combine
import StorageService

class ProfileHeaderView: UITableViewHeaderFooterView {
    
//MARK: - Properties
    private var statusText = ""
    var subscription = Set<AnyCancellable>()
    var user: User? {
        didSet {
            guard let user = user else { return }

            profileImage.image = user.avatarImage
            nameLabel.text = user.fullName
            statusLabel.text = user.status.isEmpty ? "Waiting for something..." : user.status
        }
    }
//MARK: - Views
    let profileImage: UIImageView = {
        let image = UIImageView()
        image.layer.borderWidth = 3
        image.layer.borderColor = UIColor.white.cgColor
        image.layer.cornerRadius = 75
        image.clipsToBounds = true
        image.isUserInteractionEnabled = true
        return image
    }()
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
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
        label.textColor = .gray
        return label
    }()
    
    let semitransparentView: UIView = {
        let view = UIView(frame: UIScreen.main.bounds)
        view.alpha = 0
        
        view.backgroundColor = .white
        return view
    }()
    
    lazy var statusTextField: UITextField = {
        let textField = UITextField()
        textField.backgroundColor = .white
        
        textField.layer.borderWidth = 1
        textField.layer.borderColor = UIColor.black.cgColor
        textField.layer.cornerRadius = 12
        textField.textAlignment = .center
        textField.delegate = self
        textField.font = .systemFont(ofSize: 15, weight: .regular)
        textField.textColor = .black
        textField.delegate = self
        textField.addTarget(self, action: #selector(statusTextChanged), for: .editingChanged)

        return textField
    }()
    //MARK: - Initialisers
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        let views = [nameLabel, statusButton, statusLabel, statusTextField, semitransparentView, profileImage]
        
        views.forEach({ contentView.addSubview($0) })
        
        profileImage.snp.makeConstraints { make in
            make.top.leading.equalToSuperview().offset(16)
            make.width.height.equalTo(150)
        }
        
        nameLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(27)
            make.leading.equalTo(profileImage.snp.trailing).offset(20)
            make.trailing.equalToSuperview().offset(-16)
        }
        
        statusButton.snp.makeConstraints { make in
            make.leading.trailing.bottom.equalToSuperview().inset(UIEdgeInsets(top: 0, left: 16, bottom: 16, right: 16))
            make.top.equalTo(statusTextField.snp.bottom).offset(16)
            make.height.equalTo(50)
        }
        
        statusLabel.snp.makeConstraints { make in
            make.top.equalTo(nameLabel.snp.bottom).offset(50)
            make.leading.equalTo(profileImage.snp.trailing).offset(20)
        }
        
        statusTextField.snp.makeConstraints { make in
            make.top.equalTo(statusLabel.snp.bottom).offset(16)
            make.leading.equalTo(profileImage.snp.trailing).offset(20)
            make.trailing.equalToSuperview().offset(-16)
            make.height.equalTo(40)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

//MARK: - Acrions
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

//MARK: - UITextFieldDelegate
extension ProfileHeaderView: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        tapAction()
        self.endEditing(true)
        return true
    }
}
