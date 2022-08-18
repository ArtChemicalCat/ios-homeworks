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
    func check(password: String, forLogin login: String) -> Bool
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
        textField.placeholder = "Enter email address"
        textField.backgroundColor = .systemGray6
        textField.layer.borderColor = UIColor.lightGray.cgColor
        textField.layer.borderWidth = 0.5
        textField.layer.cornerRadius = 10
        textField.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        textField.font = .systemFont(ofSize: 16, weight: .regular)
        textField.textColor = .black
        textField.autocapitalizationType = .none
        textField.delegate = self
        textField.addTarget(self, action: #selector(checkLoginAndPasswordFields), for: .editingChanged)
        return textField
    }()
    
    private lazy var passwordTextField: UITextField = {
        let textField = UITextField()
        let padding = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 16))
        textField.leftView = padding
        textField.leftViewMode = .always
        textField.placeholder = "Enter password"
        textField.backgroundColor = .systemGray6
        textField.layer.borderColor = UIColor.lightGray.cgColor
        textField.layer.borderWidth = 0.5
        textField.layer.cornerRadius = 10
        textField.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        textField.font = .systemFont(ofSize: 16, weight: .regular)
        textField.autocapitalizationType = .none
        textField.isSecureTextEntry = true
        textField.delegate = self
        textField.addTarget(self, action: #selector(checkLoginAndPasswordFields), for: .editingChanged)
        return textField
    }()
    
    private lazy var loginButton: CustomButton = {
        let button = CustomButton(withTitle: "Log In", action: logIn)

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
    
    private lazy var signupButton: CustomButton = {
        let button = CustomButton(withTitle: "Sign Up", action: signUp)
        
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
    
    private let viewModel: LoginViewModel
    
    //MARK: - LifeCycle
    init(viewModel: LoginViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        layout()
        bind(to: viewModel)
        keyboardSizePublisher
            .sink { [unowned self] height in
                self.scrollView.contentInset.bottom = height
                self.scrollView.verticalScrollIndicatorInsets = UIEdgeInsets(top: 0, left: 0, bottom: height, right: 0)
            }
            .store(in: &subscriptions)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        tabBarController?.tabBar.isHidden = true
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        tabBarController?.tabBar.isHidden = false
    }
    
    //MARK: - Metods
    private func layout() {
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        [logoImage, loginTextField,
         passwordTextField, loginButton,
         signupButton].forEach { contentView.addSubview($0) }
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
            
            signupButton.topAnchor.constraint(equalTo: loginButton.bottomAnchor, constant: 16),
            signupButton.heightAnchor.constraint(equalToConstant: 50),
            signupButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            signupButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            signupButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)

        ])
    }
    
    private func bind(to viewModel: LoginViewModel) {
        viewModel.$errorMessage
            .receive(on: DispatchQueue.main)
            .sink { [weak self] message in
                guard let message = message else { return }
                
                self?.presentAlert(with: message)
            }
            .store(in: &subscriptions)
        
        viewModel.$isLoginButtonEnabled
            .removeDuplicates()
            .receive(on: DispatchQueue.main)
            .sink { [weak self] isEnabled in
                self?.loginButton.isEnabled = isEnabled
                self?.loginButton.alpha = isEnabled ? 1 : 0.6
                self?.signupButton.isEnabled = isEnabled
                self?.signupButton.alpha = isEnabled ? 1 : 0.6

            }
            .store(in: &subscriptions)
    }
    
    private func presentAlert(with message: String) {
        let alert = UIAlertController(title: "Ошибка", message: message, preferredStyle: .alert)
        let cancel = UIAlertAction(title: "Отмена", style: .cancel)
        alert.addAction(cancel)
        present(alert, animated: true)
    }
    
    //MARK: - Actions
    private func logIn() {
        guard let email = loginTextField.text,
              let password = passwordTextField.text,
              !email.isEmpty && !password.isEmpty else { return }
        
        viewModel.checkCredentials(email: email, password: password)
    }
    
    private func signUp() {
        guard let email = loginTextField.text,
              let password = passwordTextField.text,
              !email.isEmpty && !password.isEmpty else { return }
        
        viewModel.signUp(email: email, password: password)
    }
    
    @objc
    private func checkLoginAndPasswordFields() {
        guard let login = loginTextField.text, let password = passwordTextField.text else {
            viewModel.isLoginButtonEnabled = false
            return
        }
        viewModel.isLoginButtonEnabled = !login.isEmpty && !password.isEmpty
    }
}

//MARK: - UITextFieldDelegate
extension LogInViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        view.endEditing(true)
        return true
    }
}

