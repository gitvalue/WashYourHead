//
//  WashPeriodSetUpViewModel.swift
//  WashYourHead
//
//  Created by Admin on 14/03/2024.
//

import Combine
import Foundation
import SwiftData

@MainActor
final class WashPeriodSetUpViewModel: ObservableObject {
    
    // MARK: - Properties
    
    let header: String = "Давайте определим как часто вы хотите мыть голову"
    
    var sliderLowerBound: String { String(format: "%.0f", sliderRange.lowerBound) }
    var sliderUpperBound: String { String(format: "%.0f", sliderRange.upperBound) }
    
    let sliderRange: ClosedRange<Float> = 1...7
    let sliderStep: Float = 1
    
    @Published var sliderValue: Float = .zero {
        didSet {
            sliderTitle = sliderTitle(forPeriod: Int(sliderValue))
            
            if let context = lazyModelContext() {
                var fetchDescriptor = FetchDescriptor<SettingsEntityModel>()
                fetchDescriptor.includePendingChanges = true
                
                do {
                    try context.delete(model: SettingsEntityModel.self)
                    context.insert(SettingsEntityModel(washingPeriod: Int(sliderValue)))
                }
                catch {
                    while false {}
                }
            }
        }
    }
    
    @Published private(set) var sliderTitle: String = ""
    
    private let lazyModelContext: @MainActor () -> (ModelContext?)
     
    // MARK: - Initialisers
    
    init(lazyModelContext: @MainActor @escaping () -> (ModelContext?)) {
        self.lazyModelContext = lazyModelContext
        
        defer {
            setInitialSliderValue()
        }
    }
    
    // MARK: - Private
    
    private func setInitialSliderValue() {
        let defaultSliderValue = sliderRange.upperBound
        
        guard let context = lazyModelContext() else {
            sliderValue = defaultSliderValue
            return
        }
        
        var fetchDescriptor = FetchDescriptor<SettingsEntityModel>()
        fetchDescriptor.includePendingChanges = true
        
        do {
            let settings = try context.fetch(fetchDescriptor).first
            sliderValue = (settings?.washingPeriod).map { Float($0) } ?? defaultSliderValue
        } catch {
            sliderValue = defaultSliderValue
        }
    }
    
    private func sliderTitle(forPeriod period: Int) -> String {
        if period % 10 == 1 {
            switch period {
            case 1:
                return "Каждый день"
            case 11:
                return "Каждые 11 дней"
            default:
                return "Каждый \(period) день"
            }
        }
        else if period % 10 < 5 {
            return "Каждые \(period) дня"
        }
        else {
            return "Каждые \(period) дней"
        }
    }
}
