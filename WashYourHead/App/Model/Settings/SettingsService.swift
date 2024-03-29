//
//  SettingsService.swift
//  WashYourHead
//
//  Created by Admin on 29/03/2024.
//

import Foundation
import SwiftData

protocol SettingsServiceProtocol: AnyObject {
    var settings: SettingsEntityModel? { get }
    func setWashingPeriod(_ washingPeriod: Int)
}

final class SettingsService: SettingsServiceProtocol {
    var settings: SettingsEntityModel? {
        var fetchDescriptor = FetchDescriptor<SettingsEntityModel>()
        fetchDescriptor.includePendingChanges = true
        
        return try? modelContext.fetch(fetchDescriptor).first
    }
    
    private let modelContext: ModelContext
    
    init(modelContext: ModelContext) {
        self.modelContext = modelContext
    }
    
    func setWashingPeriod(_ washingPeriod: Int) {
        var fetchDescriptor = FetchDescriptor<SettingsEntityModel>()
        fetchDescriptor.includePendingChanges = true
        
        let entities = try? modelContext.fetch(fetchDescriptor)
        entities?.forEach {
            modelContext.delete($0)
        }
        
        modelContext.insert(SettingsEntityModel(washingPeriod: washingPeriod))
        try? modelContext.save()
    }
}
