//
//  InfoViewController.swift
//  Navigation
//
//  Created by Николай Казанин on 03.03.2022.
//

import UIKit
import SnapKit

class InfoViewController: UIViewController {
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        return label
    }()
    
    private let tatooineLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        return label
    }()
    
    let screenWidth = UIScreen.main.bounds.width
    let screenHeight = UIScreen.main.bounds.height
    
    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        layout()
//        setupAlertButton()
        getTitle()
        getPlanetInfo()
    }
    
    //MARK: - Metods
    private func setupAlertButton() {
        let alertButton = CustomButton(withTitle: "Удалить пост", action: { [unowned self] in
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
    
    private func getTitle() {
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/todos/5") else { return }
        URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            if let error = error {
                print(error)
                return
            }
            
            guard let response = response as? HTTPURLResponse,
            response.statusCode == 200,
            let data = data else {
                return
            }
            
            do {
                guard let jsonObject = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] else { return }
                guard let userID = jsonObject["userId"] as? Int,
                      let id = jsonObject["id"] as? Int,
                      let title = jsonObject["title"] as? String,
                      let completed = jsonObject["completed"] as? Bool else {
                    print("ошибка при декодировании json")
                    return
                }
                
                let toDoItem = ToDoItem(userId: userID, id: id, title: title, completed: completed)
                DispatchQueue.main.async {
                    self?.setTitle(for: toDoItem)
                }
            } catch {
                print(error)
            }
        }.resume()
    }
    
    private func getPlanetInfo() {
        guard let url = URL(string: "https://swapi.dev/api/planets/1") else { return }
        URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            if let error = error {
                print(error)
                return
            }
            
            guard let response = response as? HTTPURLResponse,
            response.statusCode == 200,
            let data = data else {
                return
            }
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase // CodingKeys не пригодились)
            do {
                let tatooine = try decoder.decode(Planet.self, from: data)
                DispatchQueue.main.async {
                    self?.setOrbitalPeriod(for: tatooine)
                }
            } catch {
                print(error)
            }
            
        }.resume()
    }
    
    private func setTitle(for toDoItem: ToDoItem) {
        titleLabel.text = toDoItem.title
    }
    
    private func setOrbitalPeriod(for planet: Planet) {
        tatooineLabel.text = "Период вращения татуина вокруг своей оси составляет \(planet.orbitalPeriod)"
    }
    
    private func layout() {
        view.addSubview(titleLabel)
        view.addSubview(tatooineLabel)
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(view).offset(16)
            make.leading.trailing.equalTo(view.safeAreaLayoutGuide).offset(16)
        }
        
        tatooineLabel.snp.makeConstraints { make in
            make.leading.trailing.equalTo(titleLabel)
            make.top.equalTo(titleLabel.snp.bottom).offset(20)
        }
    }
}
