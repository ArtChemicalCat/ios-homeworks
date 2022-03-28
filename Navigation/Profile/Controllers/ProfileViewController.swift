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
        view.sectionHeaderHeight = UITableView.automaticDimension
        view.estimatedSectionHeaderHeight = 280
        view.rowHeight = UITableView.automaticDimension
        view.estimatedRowHeight = 150
        view.register(PostTableViewCell.self, forCellReuseIdentifier: PostTableViewCell.id)
        view.register(ProfileHeaderView.self, forHeaderFooterViewReuseIdentifier: ProfileHeaderView.id)
        view.register(PhotosTableViewCell.self, forCellReuseIdentifier: PhotosTableViewCell.id)
        
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
        view.backgroundColor = .lightGray
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            
        ])
    }
    
    @objc
    private func handleTap() {
        navigationController?.pushViewController(PhotosViewController(), animated: true)
    }
    
}

//MARK: - UITableViewDelegate
extension ProfileViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section == 0 {
            let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: ProfileHeaderView.id) as! ProfileHeaderView
            return header
            
        }
        return nil
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
    func numberOfSections(in tableView: UITableView) -> Int {
        2
    }
    
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
            
            return cell
        }
        
    }
    
}
