//
//  ProfileViewController.swift
//  Navigation
//
//  Created by Николай Казанин on 02.03.2022.
//

import UIKit

class ProfileViewController: UIViewController {
    
    lazy var tableView: UITableView = {
            let view = UITableView(frame: .zero, style: .grouped)
            view.translatesAutoresizingMaskIntoConstraints = false
            view.delegate = self
            view.dataSource = self
            view.register(PostTableViewCell.self, forCellReuseIdentifier: String(describing: PostTableViewCell.self))
            view.register(ProfileHeaderView.self, forHeaderFooterViewReuseIdentifier: String(describing: ProfileHeaderView.self))
            
            return view
        }()
//MARK: - Properties
    private lazy var originalAvatarPosition: CGPoint = .zero
    
    let myButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Tap me!", for: .normal)
        button.configuration = .bordered()
        return button
    }()
    
    lazy var closeButton: UIButton = {
        let button = UIButton(type: .roundedRect)
        button.setImage(UIImage(systemName: "xmark"), for: .normal)
        button.backgroundColor = .red
        button.alpha = 0
        button.addTarget(self, action: #selector(closeButtonAction), for: .touchUpInside)
        
        return button
    }()
    
//MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        layout()
        navigationController?.navigationBar.isHidden = true
}
    
//MARK: - Layout
    private func layout() {
        view.backgroundColor = .lightGray
        [myButton, tableView, closeButton].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview($0)
        }
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            
            myButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            myButton.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            myButton.trailingAnchor.constraint(equalTo: view.trailingAnchor),

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

extension ProfileViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
       let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: String(describing: ProfileHeaderView.self)) as! ProfileHeaderView
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(profileImageDidTapped))
        headerView.addGestureRecognizer(tapGesture)
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        280
    }
}



extension ProfileViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        Post.posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let post = Post.posts[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: PostTableViewCell.self), for: indexPath) as! PostTableViewCell
        cell.post = post
        return cell
    }
    
}
