//
//  FavoritePostsViewController.swift
//  Navigation
//
//  Created by Николай Казанин on 05.10.2022.
//

import UIKit
import StorageService
import SnapKit
import Combine

final class FavoritePostsViewController: UIViewController {
    // MARK: - Views
    private lazy var tableView = UITableView()
        .with {
            $0.rowHeight = UITableView.automaticDimension
            $0.estimatedRowHeight = 150
            $0.register(PostTableViewCell.self, forCellReuseIdentifier: PostTableViewCell.id)
            $0.delegate = self
            $0.dataSource = self
        }
    
    private var subscriptions = Set<AnyCancellable>()
    private var favouritePosts = [Post]() { didSet { tableView.reloadData() } }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        layout()
        getPosts()
        FavouritePostsRepository
            .shared
            .favouritePostsChangesPublisher()
            .sink { [weak self] _ in
                self?.getPosts()
            }
            .store(in: &subscriptions)
    }
    
    private func getPosts() {
        favouritePosts = FavouritePostsRepository.shared.getAllPosts()
    }
    
    private func layout() {
        view.addSubview(tableView)
        
        tableView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}

extension FavoritePostsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        favouritePosts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(
            withIdentifier: PostTableViewCell.id,
            for: indexPath
        ) as! PostTableViewCell
        cell.post = favouritePosts[indexPath.row]
        
        return cell
    }
    
    
}

extension FavoritePostsViewController: UITableViewDelegate {
    
}
