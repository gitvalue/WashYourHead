//
//  HistoryEntryEntityModel.swift
//  WashYourHead
//
//  Created by Dmitry Volosach on 10/03/2024.
//

import Foundation
import SwiftData

@Model
final class HistoryEntryEntityModel {
    let date: Date
    
    init(date: Date) {
        self.date = date
    }
}
