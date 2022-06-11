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
        
        let alertButton = CustomButton(with: "Удалить пост", action: { [unowned self] in
            showAlert()
        })
        alertButton.frame = CGRect(origin: view.center, size: CGSize(width: 200, height: 50))
        alertButton.center = view.center
        view.addSubview(alertButton)
    }
    
    private func showAlert() {
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
