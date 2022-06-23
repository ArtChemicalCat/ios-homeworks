//
//  PasswordHacker.swift
//  
//
//  Created by Николай Казанин on 23.06.2022.
//

import Foundation

final class PasswordHacker {
    func generateBruteForce(_ string: String, fromArray array: [String]) -> String {
        var str: String = string

        if str.count <= 0 {
            str.append(characterAt(index: 0, array))
        }
        else {
            str.replace(at: str.count - 1,
                        with: characterAt(index: (indexOf(character: str.last!, array) + 1) % array.count, array))

            if indexOf(character: str.last!, array) == 0 {
                str = String(generateBruteForce(String(str.dropLast()), fromArray: array)) + String(str.last!)
            }
        }

        return str
    }
    
    //MARK: - Helpers Metods
    private func indexOf(character: Character, _ array: [String]) -> Int {
        return array.firstIndex(of: String(character))!
    }

    private func characterAt(index: Int, _ array: [String]) -> Character {
        return index < array.count ? Character(array[index])
                                   : Character("")
    }
}

extension String {
    static var digits:      String { return "0123456789" }
    static var lowercase:   String { return "abcdefghijklmnopqrstuvwxyz" }
    static var uppercase:   String { return "ABCDEFGHIJKLMNOPQRSTUVWXYZ" }
    static var punctuation: String { return "!\"#$%&'()*+,-./:;<=>?@[\\]^_`{|}~" }
    static var letters:     String { return lowercase + uppercase }
    static var printable:   String { return digits + letters + punctuation }



    mutating func replace(at index: Int, with character: Character) {
        var stringArray = Array(self)
        stringArray[index] = character
        self = String(stringArray)
    }
}
