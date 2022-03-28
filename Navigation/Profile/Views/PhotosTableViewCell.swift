//
//  PhotosTableViewCell.swift
//  Navigation
//
//  Created by Николай Казанин on 22.03.2022.
//

import UIKit

class PhotosTableViewCell: UITableViewCell {
        
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
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.delegate = self
        view.dataSource = self
        
        view.register(PhotoCollectionPreviewCell.self, forCellWithReuseIdentifier: PhotoCollectionPreviewCell.id)
        
        return view
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = .white
        configureContent()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
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

extension PhotosTableViewCell: UICollectionViewDelegateFlowLayout {
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

extension PhotosTableViewCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        min(Post.photos.count, 4)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PhotoCollectionPreviewCell.id, for: indexPath) as! PhotoCollectionPreviewCell
        cell.image.image = Post.photos[indexPath.item]
        
        return cell
    }
}
