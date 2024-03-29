//
//  WashEventEntity.swift
//  WashYourHead
//
//  Created by Dmitry Volosach on 10/03/2024.
//

import Foundation
import SwiftData

@Model
final class WashEventEntity {
    let isCompleted: Bool
    let date: Date
    
    init(date: Date, isCompleted: Bool) {
        self.date = date
        self.isCompleted = isCompleted
    }
}
