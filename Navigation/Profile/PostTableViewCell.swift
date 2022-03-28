//
//  PostTableViewCell.swift
//  Navigation
//
//  Created by Николай Казанин on 21.03.2022.
//

import UIKit

class PostTableViewCell: UITableViewCell {
        
    var authorLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 20, weight: .bold)
        label.textColor = .black
        label.numberOfLines = 2
        
        return label
    }()
    
    var postImage: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFit
        image.backgroundColor = .black
        
        return image
    }()
    
    var postDescriptionTextView: UILabel = {
        let textView = UILabel()
        textView.numberOfLines = 0
        textView.textColor = .systemGray
        textView.font = .systemFont(ofSize: 14, weight: .regular)
        
        return textView
    }()
    
    var likesLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .regular)
        label.textColor = .black

        return label
    }()
    
    var viewLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .regular)
        label.textColor = .black
        
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureContent()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureContent() {
        [authorLabel, postImage, postDescriptionTextView, likesLabel, viewLabel].forEach { view in
            view.translatesAutoresizingMaskIntoConstraints = false
            contentView.addSubview(view)
        }
        
        NSLayoutConstraint.activate([
            authorLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            authorLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            
            postImage.topAnchor.constraint(equalTo: authorLabel.bottomAnchor, constant: 12),
            postImage.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            postImage.heightAnchor.constraint(equalToConstant: min(UIScreen.main.bounds.width, UIScreen.main.bounds.height)),
            postImage.widthAnchor.constraint(equalToConstant: min(UIScreen.main.bounds.width, UIScreen.main.bounds.height)),
            
            postDescriptionTextView.topAnchor.constraint(equalTo: postImage.bottomAnchor, constant: 16),
            postDescriptionTextView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            postDescriptionTextView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            
            likesLabel.topAnchor.constraint(equalTo: postDescriptionTextView.bottomAnchor, constant: 16),
            likesLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            
            viewLabel.topAnchor.constraint(equalTo: postDescriptionTextView.bottomAnchor, constant: 16),
            viewLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            viewLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16)
        ])
    }
    
}
