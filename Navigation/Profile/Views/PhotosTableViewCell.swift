//
//  PhotosTableViewCell.swift
//  Navigation
//
//  Created by Николай Казанин on 22.03.2022.
//

import UIKit

class PhotosTableViewCell: UITableViewCell {
    //так как предыдущие дз еще не проверены, пока что использовал ячейку
    //как обычную вью, потом при слиянии добавлю ее в UITableView
        
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
