//
//  InfoViewController.swift
//  Navigation
//
//  Created by Николай Казанин on 03.03.2022.
//

import UIKit

class InfoViewController: UIViewController {
    
    let screenWidth = UIScreen.main.bounds.width
    let screenHeight = UIScreen.main.bounds.height
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        let alertButton: UIButton = {
            let button = UIButton(frame: CGRect(x: screenWidth * 0.1, y: screenHeight / 2, width: screenWidth * 0.8, height: 30))
            button.setTitle("Удалить пост", for: .normal)
            button.configuration = .bordered()
            button.addTarget(self, action: #selector(showAlert), for: .touchUpInside)
            
            return button
        }()
        
        view.addSubview(alertButton)
    }
    
    @objc func showAlert(sender: UIButton!) {
        let alert: UIAlertController = {
            let alert = UIAlertController(title: "Удалить", message: "Вы точно хотите удалить пост?", preferredStyle: .alert)
            
            alert.addAction(UIAlertAction(
                title: "OK",
                style: .destructive,
                handler: { _ in
                    print("Пост удален!")
                    self.dismiss(animated: true, completion: nil)
                }))
            
            alert.addAction(UIAlertAction(
                title: "Отмена",
                style: .cancel,
                handler: { _ in
                    print("Отмена")
                }))
            
            return alert
        }()
        
        present(alert, animated: true, completion: nil)
    }
    
}
