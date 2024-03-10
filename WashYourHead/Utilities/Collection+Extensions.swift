//
//  Collection+Extensions.swift
//  WashYourHead
//
//  Created by Dmitry Volosach on 10/03/2024.
//

import Foundation

public extension Collection {
    /**
     This method checks whether index is signed int and object exists at index.
     */
    subscript(safe index: Index) -> Element? {
        return indices.contains(index) ? self[index] : nil
    }
}
