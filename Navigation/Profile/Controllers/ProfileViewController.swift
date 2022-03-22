//
//  ProfileViewController.swift
//  Navigation
//
//  Created by Николай Казанин on 02.03.2022.
//

import UIKit

class ProfileViewController: UIViewController {
    
    let photos = [
        UIImage(named: "Джеймс-Кэмерон"),
        UIImage(named: "Альфред-Хичкок"),
        UIImage(named: "Джордж-Лукас"),
        UIImage(named: "Дэнни-Вильнев"),
        UIImage(named: "Квентин-Тарантино"),
        UIImage(named: "Кристофер-Нолан"),
        UIImage(named: "Дэвид-Финчер"),
        UIImage(named: "Мартин-Скорсезе"),
        UIImage(named: "Роберт-Земекис"),
        UIImage(named: "Стивен-Спилберг")
    ]
    
    let profileHeaderView: ProfileHeaderView = {
        let view = ProfileHeaderView()
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    private lazy var photoTablePreviewCell: PhotosTableViewCell = {
        let view = PhotosTableViewCell()
        view.collectionView.delegate = self
        view.collectionView.dataSource = self
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        view.addGestureRecognizer(tap)
        
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemGray5
        layout()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = true
    }
    
    private func layout() {
        view.addSubview(photoTablePreviewCell)
        view.addSubview(profileHeaderView)
        photoTablePreviewCell.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            profileHeaderView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            profileHeaderView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            profileHeaderView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            
            photoTablePreviewCell.topAnchor.constraint(equalTo: profileHeaderView.bottomAnchor),
            photoTablePreviewCell.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            photoTablePreviewCell.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            photoTablePreviewCell.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    @objc
    private func handleTap() {
        navigationController?.pushViewController(PhotosViewController(), animated: true)
    }
    
}
//MARK: - UICollectionViewDelegate

extension ProfileViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (collectionView.bounds.width - 8 * 6) / 4
        
        return CGSize(width: width, height: width)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        UIEdgeInsets(top: 12, left: 12, bottom: 12, right: 12)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        8
    }
}
//MARK: - UICollectionViewDataSource

extension ProfileViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        min(photos.count, 4)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PhotoCollectionPreviewCell.id, for: indexPath) as! PhotoCollectionPreviewCell
        cell.image.image = photos[indexPath.item]
        
        return cell
    }
    
    
}
