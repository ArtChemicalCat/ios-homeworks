//
//  ProfileViewController.swift
//  Navigation
//
//  Created by Николай Казанин on 02.03.2022.
//

import UIKit

class ProfileViewController: UIViewController {
    
    let posts = [
        Post(author: "DigsDigs", description: "53 Industrial Bathroom Designs With Vintage Or Minimalist Chic",
             image: "bathroom",
             likes: 123,
             views: 56),
        Post(author: "Кинопоиск",
             description: "От броских экранизаций комиксов и ярких мюзиклов до симпатичного авторского кино — фильмы-фавориты редакции Кинопоиска",
             image: "kinopoisk",
             likes: 587,
             views: 843),
        Post(author: "Kuda Spb",
             description: "В «Галерее Кустановича» проходит новая выставка картин петербургского художника Дмитрия Кустановича — «Продолжение». Галерея, посвященная творчеству одного художника, работает в самом центре Санкт-Петербурга уже почти 12 лет. Вход свободный.   Источник — kuda-spb.ru, лучшие события Санкт-Петербурга.",
             image: "vistavka",
             likes: 89,
             views: 156),
        Post(author: "Игромания", description: "Нового «Бэтмена» мы в обозримом будущем не увидим, и это печально: зарубежные критики и зрители расхваливают картину на все лады. Да, цифровой релиз назначен уже на 19 апреля, и в тот же день фильм гарантированно спиратят (осуждаем, но сдержанно), но посмотреть-то хочется уже сейчас, и не кривую экранку. Понимаем, сочувствуем, а потому подготовили список того, чем можно компенсировать дефицит «Бэтмена» в организме уже сейчас. Ни трилогии Нолана, ни фильмов Бёртона вы тут не найдёте: это уж слишком очевидно. Но зато мы включили ленты, которыми вдохновлялся режиссёр Мэтт Ривз, близкие по духу экранизации комиксов, а заодно самые атмосферные анимационные полнометражки про готэмского защитника.", image: "batman", likes: 547, views: 720)
    ]
    
    
    lazy var tableView: UITableView = {
        let view = UITableView(frame: .zero, style: .grouped)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.delegate = self
        view.dataSource = self
        view.register(PostTableViewCell.self, forCellReuseIdentifier: String(describing: PostTableViewCell.self))
        view.register(ProfileHeaderView.self, forHeaderFooterViewReuseIdentifier: String(describing: ProfileHeaderView.self))
        
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        layout()

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
}

extension ProfileViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        tableView.dequeueReusableHeaderFooterView(withIdentifier: String(describing: ProfileHeaderView.self))
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        280
    }
}



extension ProfileViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let post = posts[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: PostTableViewCell.self), for: indexPath) as! PostTableViewCell
        cell.postImage.image = UIImage(named: post.image)
        cell.authorLabel.text = post.author
        cell.postDescriptionTextView.text = post.description
        cell.likesLabel.text = "Likes: \(post.likes)"
        cell.viewLabel.text = "Views: \(post.views)"
        
        return cell
    }
    
}
