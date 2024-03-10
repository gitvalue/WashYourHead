//
//  UpdatableView.swift
//  WashYourHead
//
//  Created by Dmitry Volosach on 10/03/2024.
//

import Foundation

// Протокол обновляемой вьюхи
public protocol UpdatableView: AnyObject {
    associatedtype ModelType
    func update(model: ModelType)
}
