//
//  SettingsEntityModel.swift
//  WashYourHead
//
//  Created by Admin on 10/03/2024.
//

import SwiftData

@Model
final class SettingsEntityModel {
    let washingPeriod: Int
    
    init(washingPeriod: Int) {
        self.washingPeriod = washingPeriod
    }
}
