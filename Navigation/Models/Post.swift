//
//  Post.swift
//  Navigation
//
//  Created by Николай Казанин on 03.03.2022.
//

import UIKit


struct Post {
    var title: String = ""
    let author: String
    let description: String
    let image: String
    let likes: Int
    let views: Int
    
    static let posts = [
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
    
    static var photos = [
        UIImage(named: "Джеймс-Кэмерон"),
        UIImage(named: "Альфред-Хичкок"),
        UIImage(named: "Джордж-Лукас"),
        UIImage(named: "Дэнни-Вильнев"),
        UIImage(named: "Квентин-Тарантино"),
        UIImage(named: "Кристофер-Нолан"),
        UIImage(named: "Дэвид-Финчер"),
        UIImage(named: "Мартин-Скорсезе"),
        UIImage(named: "Роберт-Земекис"),
        UIImage(named: "Джеймс-Кэмерон"),
        UIImage(named: "Альфред-Хичкок"),
        UIImage(named: "Джордж-Лукас"),
        UIImage(named: "Дэнни-Вильнев"),
        UIImage(named: "Квентин-Тарантино"),
        UIImage(named: "Кристофер-Нолан"),
        UIImage(named: "Дэвид-Финчер"),
        UIImage(named: "Мартин-Скорсезе"),
        UIImage(named: "Роберт-Земекис"),
        UIImage(named: "Стивен-Спилберг"),
        UIImage(named: "Стивен-Спилберг")
    ]
}
