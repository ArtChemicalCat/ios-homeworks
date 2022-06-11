//
//  FeedModel.swift
//  Navigation
//
//  Created by Николай Казанин on 08.06.2022.
//

import Foundation
import Combine

class FeedModel {
    private let answer = "огнетушитель"
    
    @Published var isAnswerCorrect = false
    
    func check(word: String) {
        isAnswerCorrect = word.lowercased() == answer
    }
}
