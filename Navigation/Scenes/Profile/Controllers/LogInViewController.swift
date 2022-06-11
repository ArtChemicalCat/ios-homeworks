//
//  LogInViewController.swift
//  Navigation
//
//  Created by Николай Казанин on 19.03.2022.
//

import UIKit
import Combine
import StorageService

protocol LogInViewControllerDelegate {
    func check(password: String, for login: String) -> Bool
}

class LogInViewController: UIViewController {
    //MARK: - Views
    private let logoImage: UIImageView = {
        let image = UIImageView(image: UIImage(named: "logo"))
        
        return image
    }()
    
    private lazy var loginTextField: UITextField = {
        let textField = UITextField()
        let padding = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 16))
        textField.leftView = padding
        textField.leftViewMode = .always
        textField.placeholder = "Email or phone (artchemist@yandex.ru)"
        textField.backgroundColor = .systemGray6
        textField.layer.borderColor = UIColor.lightGray.cgColor
        textField.layer.borderWidth = 0.5
        textField.layer.cornerRadius = 10
        textField.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        textField.font = .systemFont(ofSize: 16, weight: .regular)
        textField.textColor = .black
        textField.autocapitalizationType = .none
        textField.delegate = self
        return textField
    }()
    
    private lazy var passwordTextField: UITextField = {
        let textField = UITextField()
        let padding = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 16))
        textField.leftView = padding
        textField.leftViewMode = .always
        textField.placeholder = "Password (qwerty123)"
        textField.backgroundColor = .systemGray6
        textField.layer.borderColor = UIColor.lightGray.cgColor
        textField.layer.borderWidth = 0.5
        textField.layer.cornerRadius = 10
        textField.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        textField.font = .systemFont(ofSize: 16, weight: .regular)
        textField.autocapitalizationType = .none
        textField.isSecureTextEntry = true
        textField.delegate = self
        
        return textField
    }()
    
    private lazy var loginButton: CustomButton = {
        let button = CustomButton(with: "Log In") { [unowned self] in
            loginAction()
        }
        let image = UIImage(named: "blue_pixel")!
        button.setBackgroundImage(image, for: .normal)
        button.clipsToBounds = true
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 10
        button.publisher(for: \.isHighlighted)
            .sink { state in
                button.alpha = state ? 0.8 : 1
            }
            .store(in: &subscriptions)
        return button
    }()
    
    private let scrollView: UIScrollView = {
        let view = UIScrollView()
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    private let contentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    //MARK: - Properties
    private var subscriptions: Set<AnyCancellable> = []
    private var keyboardSizePublisher: AnyPublisher<CGFloat, Never> {
        
        let willShow = NotificationCenter.default.publisher(for: UIApplication.keyboardWillShowNotification)
            .map { ($0.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect)?.height ?? 0 }
        
        let willHide = NotificationCenter.default.publisher(for: UIApplication.keyboardWillHideNotification)
            .map { _ in CGFloat(0) }
        
        return Publishers.MergeMany(willHide, willShow)
            .eraseToAnyPublisher()
    }
    
    var delegate: LogInViewControllerDelegate!
    
    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        layout()
        keyboardSizePublisher
            .sink { [unowned self] height in
                self.scrollView.contentInset.bottom = height
                self.scrollView.verticalScrollIndicatorInsets = UIEdgeInsets(top: 0, left: 0, bottom: height, right: 0)
            }
            .store(in: &subscriptions)
    }
    
    //MARK: - Layout
    private func layout() {
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        [logoImage, loginTextField, passwordTextField, loginButton].forEach { contentView.addSubview($0) }
        contentView.subviews.forEach { $0.translatesAutoresizingMaskIntoConstraints = false }
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            
            logoImage.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 120),
            logoImage.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            logoImage.heightAnchor.constraint(equalToConstant: 100),
            logoImage.widthAnchor.constraint(equalToConstant: 100),
            
            loginTextField.topAnchor.constraint(equalTo: logoImage.bottomAnchor, constant: 120),
            loginTextField.heightAnchor.constraint(equalToConstant: 50),
            loginTextField.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            loginTextField.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            
            passwordTextField.topAnchor.constraint(equalTo: loginTextField.bottomAnchor),
            passwordTextField.heightAnchor.constraint(equalToConstant: 50),
            passwordTextField.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            passwordTextField.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            
            loginButton.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 16),
            loginButton.heightAnchor.constraint(equalToConstant: 50),
            loginButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            loginButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            loginButton.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor)
        ])
    }
    
    //MARK: - Actions
    @objc
    private func loginAction() {
        var userService: UserService = CurrentUserService()
        #if DEBUG
        userService = TestUserService()
        #endif
        
        guard let email = loginTextField.text,
              let password = passwordTextField.text,
              delegate.check(password: password, for: email) else {
    
            presentAlert(with: "Неверный email и/или пароль")
            return
        }
        
        let profileVC = ProfileViewController(email: email, userService: userService)
        
        navigationController?.pushViewController(profileVC, animated: true)
    }
    
    private func presentAlert(with message: String) {
        let alert = UIAlertController(title: "Ошибка", message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .cancel)
        alert.addAction(action)
        present(alert, animated: true)
    }
        
}

//MARK: - UITextFieldDelegate
extension LogInViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        view.endEditing(true)
        
        return true
    }
}

