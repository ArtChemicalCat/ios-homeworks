//
//  PhotosTableViewCell.swift
//  Navigation
//
//  Created by Николай Казанин on 20.05.2022.
//

import UIKit
import StorageService
import iOSIntPackage

class PhotosTableViewCell: UITableViewCell {
    //MARK: - Views
    let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Photos"
        label.textColor = .black
        label.font = .systemFont(ofSize: 24, weight: .bold)
        
        return label
    }()
    
    let arrowImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(systemName: "arrow.right")
        image.contentMode = .scaleAspectFit
        
        return image
    }()
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.dataSource = self
        view.register(PhotoCollectionPreviewCell.self, forCellWithReuseIdentifier: PhotoCollectionPreviewCell.id)
        
        return view
    }()
    //MARK: - Properties
    private var photos: [UIImage]
    
    //MARK: - Initializers
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        photos = Post.photos.compactMap { $0 }
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = .white
        configureContent()
        
        let startDate = Date()
        ImageProcessor().processImagesOnThread(sourceImages: photos,
                                               filter: .posterize,
                                               qos: .default) { [weak self] images in
            guard let self = self else { return }
            self.photos = images
                .compactMap { $0 }
                .map { UIImage(cgImage: $0) }
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
            print("Изображения были обработаны в течении \(Date().timeIntervalSince(startDate)) секунд")
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Metods
    private func configureContent() {
        contentView.addSubview(titleLabel)
        contentView.addSubview(arrowImage)
        contentView.addSubview(collectionView)
        contentView.subviews.forEach { $0.translatesAutoresizingMaskIntoConstraints = false }
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 12),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 12),
            
            arrowImage.centerYAnchor.constraint(equalTo: titleLabel.centerYAnchor),
            arrowImage.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -12),
            
            collectionView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
}

//MARK: - UICollectionViewDataSource
extension PhotosTableViewCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        photos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PhotoCollectionPreviewCell.id, for: indexPath) as! PhotoCollectionPreviewCell
        cell.image.image = photos[indexPath.item]
        
        return cell
    }
}
