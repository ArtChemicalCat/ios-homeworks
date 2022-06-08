//
//  CustomButton.swift
//  Navigation
//
//  Created by Николай Казанин on 08.06.2022.
//

import UIKit

final class CustomButton: UIButton {
    typealias Action = () -> Void
    
    //MARK: - Properties
    private let buttonAction: Action
    
    //MARK: - Initialisers
    init(with title: String, backgroundColor: UIColor = UIColor(named: "Color")!, action: @escaping Action) {
        buttonAction = action
        super.init(frame: .zero)
        layer.cornerRadius = 8
        self.backgroundColor = backgroundColor
        setTitle(title, for: .normal)
        addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Action
    @objc private func buttonTapped() {
        buttonAction()
    }
    
    //MARK: - Metods
    public func padding(_ insets: UIEdgeInsets) {
        contentEdgeInsets = insets
    }
}
