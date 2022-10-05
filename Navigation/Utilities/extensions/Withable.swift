//
//  Withable.swift
//  Navigation
//
//  Created by Николай Казанин on 05.10.2022.
//

import Foundation

protocol Withable {
    associatedtype T
    func with(_ block: (T) -> Void) -> T
}

extension Withable {
    @discardableResult
    func with(_ block: (Self) -> Void) -> Self {
        block(self)
        return self
    }
}

extension NSObject: Withable {}
