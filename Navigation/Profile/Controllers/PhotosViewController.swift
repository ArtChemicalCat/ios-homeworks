//
//  PhotosViewController.swift
//  Navigation
//
//  Created by Николай Казанин on 22.03.2022.
//

import UIKit

class PhotosViewController: UIViewController {
    
    private var photos = [
        UIImage(named: "Джеймс-Кэмерон"),
        UIImage(named: "Альфред-Хичкок"),
        UIImage(named: "Джордж-Лукас"),
        UIImage(named: "Дэнни-Вильнев"),
        UIImage(named: "Квентин-Тарантино"),
        UIImage(named: "Кристофер-Нолан"),
        UIImage(named: "Дэвид-Финчер"),
        UIImage(named: "Мартин-Скорсезе"),
        UIImage(named: "Роберт-Земекис"),
        UIImage(named: "Джеймс-Кэмерон"),
        UIImage(named: "Альфред-Хичкок"),
        UIImage(named: "Джордж-Лукас"),
        UIImage(named: "Дэнни-Вильнев"),
        UIImage(named: "Квентин-Тарантино"),
        UIImage(named: "Кристофер-Нолан"),
        UIImage(named: "Дэвид-Финчер"),
        UIImage(named: "Мартин-Скорсезе"),
        UIImage(named: "Роберт-Земекис"),
        UIImage(named: "Стивен-Спилберг"),
        UIImage(named: "Стивен-Спилберг")
    ]
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.dataSource = self
        view.delegate = self
        view.register(PhotoCollectionViewCell.self, forCellWithReuseIdentifier: PhotoCollectionViewCell.id)
        
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        photos.shuffle()
        layout()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = false
        navigationItem.title = "Photo Gallery"
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        navigationController?.isNavigationBarHidden = false
    }
    
    private func layout() {
        view.addSubview(collectionView)
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }

}

extension PhotosViewController: UICollectionViewDelegateFlowLayout {
    
    private var edgeInset: CGFloat {
        8
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (collectionView.bounds.width - edgeInset * 4) / 3
        
        return CGSize(width: width, height: width)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        UIEdgeInsets(top: edgeInset, left: edgeInset, bottom: edgeInset, right: edgeInset)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        edgeInset
    }
}

extension PhotosViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        photos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PhotoCollectionViewCell.id, for: indexPath) as! PhotoCollectionViewCell
        cell.image.image = photos[indexPath.item]
        
        return cell
    }
    
    
}
