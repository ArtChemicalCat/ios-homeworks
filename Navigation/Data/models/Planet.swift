//
//  Planet.swift
//  Navigation
//
//  Created by Николай Казанин on 28.07.2022.
//

import Foundation

struct Planet: Codable {
    let name: String
    let rotationPeriod: String
    let orbitalPeriod: String
    let diameter: String
    let climate: String
    let gravity: String
    let residents: [URL?]
}
