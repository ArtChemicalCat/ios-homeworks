//
//  FeedViewController.swift
//  Navigation
//
//  Created by Николай Казанин on 02.03.2022.
//

import UIKit
import StorageService
import SnapKit
import Combine

class FeedViewController: UIViewController {
    //MARK: - Views
    private lazy var firstButton = CustomButton(withTitle: "Пост №1") { [unowned self] in
            coordinator.showPostVC()
        }
    
    private lazy var secondButton = CustomButton(withTitle: "Пост №2") { [unowned self] in
            coordinator.showPostVC()
        }

    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 10
        stackView.distribution = .fillEqually
        stackView.addArrangedSubview(firstButton)
        stackView.addArrangedSubview(secondButton)
        return stackView
    }()
    
    private let answerTextField: UITextField = {
        let textField = UITextField()
        let spacer = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 10))
        textField.backgroundColor = .systemGray4
        textField.leftView = spacer
        textField.layer.cornerRadius = 6
        textField.leftViewMode = .always
        textField.placeholder = "Guess the word(огнетушитель)"
        return textField
    }()
    
    private lazy var checkAnswerButton = CustomButton(withTitle: "Check") { [unowned self] in
            guard let answer = answerTextField.text, !answer.isEmpty else { return }
            model.check(word: answer)
        }
    
    private let answerLabel: UILabel = {
        let label = UILabel()
        label.layer.cornerRadius = 8
        label.clipsToBounds = true
        label.backgroundColor = .systemRed
        label.isUserInteractionEnabled = true
        label.textAlignment = .center
        label.font = .preferredFont(forTextStyle: .largeTitle)
        return label
    }()
    
    //MARK: - Properties
    private let model: FeedModel
    private var subscriptions = Array<AnyCancellable>()
    
    weak var coordinator: FeedCoordinator!
    
    //MARK: - Initializers
    init(model: FeedModel) {
        self.model = model
        super.init(nibName: nil, bundle: nil)
        bind(to: model)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Лента"
        layout()
        setupHideAnswer()
    }
    
    //MARK: - Metods
    private func bind(to model: FeedModel) {
        model.$isAnswerCorrect
            .receive(on: DispatchQueue.main)
            .dropFirst()
            .sink { [weak self] isAnswerCorrect in
                self?.answerLabel.text = isAnswerCorrect ? "ВЕРНО!" : "НЕ ВЕРНО!"
                self?.answerLabel.backgroundColor = isAnswerCorrect ? .systemGreen : .systemRed
                self?.showAnswer()
            }
            .store(in: &subscriptions)
    }
    
    private func layout() {
        view.backgroundColor = .systemBackground
        
        [stackView, checkAnswerButton, answerTextField, answerLabel].forEach {
            view.addSubview($0)
        }
        
        stackView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(12)
            make.leading.trailing.equalToSuperview().inset(12)
            make.height.equalTo(200)
        }
        
        checkAnswerButton.snp.makeConstraints { make in
            make.bottom.equalTo(view.safeAreaLayoutGuide).inset(30)
            make.centerX.equalToSuperview()
            make.leading.trailing.equalToSuperview().inset(60)
        }
        
        answerTextField.snp.makeConstraints { make in
            make.bottom.equalTo(checkAnswerButton.snp.top).offset(-16)
            make.height.equalTo(50)
            make.leading.trailing.equalToSuperview().inset(16)
        }
        
        answerLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(-400)
            make.width.equalTo(250)
            make.height.equalTo(80)
            make.centerX.equalToSuperview()
        }
    }
    
    private func setupHideAnswer() {
        let hideTap = UITapGestureRecognizer(target: self, action: #selector(hideAnswer))
        view.addGestureRecognizer(hideTap)
    }
    
    private func toggleViewControlsInteraction() {
        [firstButton, secondButton, answerTextField, checkAnswerButton].forEach {
            $0.isEnabled.toggle()
        }
    }
    
    //MARK: - Action
    private func showAnswer() {
        UIView.animate(withDuration: 0.6,
                       delay: 0,
                       usingSpringWithDamping: 0.7,
                       initialSpringVelocity: 1,
                       options: .curveEaseOut) { [weak self] in
            self?.answerLabel.snp.updateConstraints { make in
                make.top.equalToSuperview().offset((self?.view.bounds.height ?? 0) * 0.4)
            }
            self?.view.layoutIfNeeded()
        }
        toggleViewControlsInteraction()
    }
    
    @objc private func hideAnswer() {
        UIView.animate(withDuration: 0.6,
                       delay: 0,
                       usingSpringWithDamping: 0.7,
                       initialSpringVelocity: 1,
                       options: .curveEaseInOut) { [weak self] in
            self?.answerLabel.snp.updateConstraints { make in
                make.top.equalToSuperview().offset(-400)
            }
            self?.view.layoutIfNeeded()
        }
        toggleViewControlsInteraction()
    }
}
