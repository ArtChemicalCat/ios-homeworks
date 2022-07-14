//
//  NetworkManager.swift
//  Navigation
//
//  Created by Николай Казанин on 14.07.2022.
//

import Foundation

enum AppConfiguration {
    case character
    case starship
    case planet
    
    var url: URL {
        switch self {
        case .character:
            return URL(string: "https://swapi.dev/api/people/8")!
        case .starship:
            return URL(string: "https://swapi.dev/api/starships/3")!
        case .planet:
            return URL(string: "https://swapi.dev/api/planets/5")!
        }
    }
}

extension AppConfiguration: CaseIterable { }

struct NetworkManager {
    static func request(_ configuration: AppConfiguration) {
        URLSession
            .shared
            .dataTask(with: configuration.url) { data, response, error in
                if let error = error {
                    print("Error: \(error.localizedDescription)")
                    return
                }
                
                guard let response = response as? HTTPURLResponse,
                   let data = data else {
                    print("Что-то пошло не так")
                    return
                }
                
                if let jsonObject = try? JSONSerialization.jsonObject(with: data) as? [String: Any],
                   let name = jsonObject["name"] as? String {
                    print("Requested: \(name)")
                }
                
                print("Headers: \(response.allHeaderFields)")
                print("Status code: \(response.statusCode)")
            }.resume()
    }
}
