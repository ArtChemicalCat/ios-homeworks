//
//  ProfileViewController.swift
//  Navigation
//
//  Created by Николай Казанин on 02.03.2022.
//

import UIKit
import StorageService

class ProfileViewController: UIViewController {
    //MARK: - Views
    lazy var tableView: UITableView = {
        let view = UITableView(frame: .zero, style: .grouped)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .clear
        view.delegate = self
        view.dataSource = self
        view.sectionHeaderHeight = UITableView.automaticDimension
        view.estimatedSectionHeaderHeight = 280
        view.rowHeight = UITableView.automaticDimension
        view.estimatedRowHeight = 150
        view.register(PostTableViewCell.self, forCellReuseIdentifier: PostTableViewCell.id)
        view.register(ProfileHeaderView.self, forHeaderFooterViewReuseIdentifier: ProfileHeaderView.id)
        view.register(PhotosTableViewCell.self, forCellReuseIdentifier: PhotosTableViewCell.id)
        
        return view
    }()
    
    lazy var closeButton: UIButton = {
        let button = UIButton(type: .roundedRect)
        button.setImage(UIImage(systemName: "xmark"), for: .normal)
        button.backgroundColor = .red
        button.alpha = 0
        button.addTarget(self, action: #selector(closeButtonAction), for: .touchUpInside)
        
        return button
    }()
    
    
    //MARK: - Properties
    private lazy var originalAvatarPosition: CGPoint = .zero
    private let userService: UserService
    private let email: String
    
    //MARK: - Initialisers
    init(email: String, userService: UserService) {
        self.userService = userService
        self.email = email
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Профиль"
        navigationItem.hidesBackButton = true
        layout()
        
#if DEBUG
        view.backgroundColor = .systemYellow
#else
        view.backgroundColor = .systemBackground
#endif
    }
    
    //MARK: - Layout
    private func layout() {
        [tableView, closeButton].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview($0)
        }
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            
            closeButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            closeButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16)
            
        ])
    }
    
    //MARK: - Actions
    @objc private func profileImageDidTapped() {
        tableView.isScrollEnabled = false
        let header = tableView.headerView(forSection: 0) as! ProfileHeaderView
        originalAvatarPosition = header.profileImage.center
        let scale = UIScreen.main.bounds.width / header.profileImage.bounds.width
        UIView.animate(withDuration: 0.5) {
            header.profileImage.center = CGPoint(x: UIScreen.main.bounds.midX,
                                                 y: UIScreen.main.bounds.midY - header.profileImage.bounds.midY)
            header.profileImage.transform = CGAffineTransform(scaleX: scale, y: scale)
            header.profileImage.layer.cornerRadius = 0
            header.semitransparentView.alpha = 0.5
        } completion: { _ in
            UIView.animate(withDuration: 0.3) {
                self.closeButton.alpha = 1
            }
        }
    }
    
    @objc private func closeButtonAction() {
        tableView.isScrollEnabled = true
        UIView.animate(withDuration: 0.3) {
            self.closeButton.alpha = 0
            
        } completion: { _ in
            UIView.animate(withDuration: 0.5) { [unowned self] in
                let profileHeaderView = tableView.headerView(forSection: 0) as! ProfileHeaderView
                profileHeaderView.profileImage.center = self.originalAvatarPosition
                profileHeaderView.profileImage.transform = CGAffineTransform(scaleX: 1, y: 1)
                profileHeaderView.profileImage.layer.cornerRadius = profileHeaderView.profileImage.bounds.midX
                profileHeaderView.semitransparentView.alpha = 0
            }
        }
    }
}

//MARK: - UITableViewDelegate
extension ProfileViewController: UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        2
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath == IndexPath(row: 0, section: 0) {
            navigationController?.pushViewController(PhotosViewController(), animated: true)
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath == IndexPath(row: 0, section: 0) {
            return (view.bounds.width - 8 * 6) / 4 + 80
        } else {
            return UITableView.automaticDimension
        }
    }
}

//MARK: - UITableViewDataSource
extension ProfileViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 1
        default:
            return Post.posts.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 1 {
            let post = Post.posts[indexPath.row]
            let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: PostTableViewCell.self), for: indexPath) as! PostTableViewCell
            cell.post = post
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: PhotosTableViewCell.id, for: indexPath) as! PhotosTableViewCell
            cell.collectionView.delegate = self
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: String(describing: ProfileHeaderView.self)) as! ProfileHeaderView
        headerView.user = userService.getUser(with: email)
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(profileImageDidTapped))
        headerView.addGestureRecognizer(tapGesture)
        
        if section == 0 {
            return headerView
        }
        return nil
    }
}

extension ProfileViewController:  UICollectionViewDelegateFlowLayout {
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
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        navigationController?.pushViewController(PhotosViewController(), animated: true)
    }
    
}
