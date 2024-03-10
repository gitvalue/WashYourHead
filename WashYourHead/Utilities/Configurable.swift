//
//  Configurable.swift
//  WashYourHead
//
//  Created by Dmitry Volosach on 10/03/2024.
//

import Foundation

public protocol Configurable {}

public extension Configurable {
    func with(config: (inout Self) -> Void) -> Self {
        var this = self
        config(&this)
        return this
    }
}

extension NSObject: Configurable {}
