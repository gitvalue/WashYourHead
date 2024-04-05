//
//  WashPeriodSetUpViewModel.swift
//  WashYourHead
//
//  Created by Admin on 14/03/2024.
//

import Combine
import Foundation

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
            
            if isSwitchOn {
                settingsService.setWashingPeriod(Int(sliderValue))
            }
        }
    }
    
    @Published var isSwitchOn: Bool = true {
        didSet {
            if isSwitchOn {
                settingsService.setWashingPeriod(Int(sliderValue))
            } else {
                settingsService.setWashingPeriod(nil)
            }
        }
    }
    
    @Published private(set) var sliderTitle: String = ""
    
    private let settingsService: SettingsServiceProtocol
     
    // MARK: - Initialisers
    
    init(settingsService: SettingsServiceProtocol) {
        self.settingsService = settingsService
        
        defer {
            setInitialSliderValue()
        }
    }
    
    // MARK: - Private
    
    private func setInitialSliderValue() {
        if let settings = settingsService.settings, let washingPeriod = settings.washingPeriod {
            sliderValue = Float(washingPeriod)
            isSwitchOn = true
        } else {
            sliderValue = 0
            isSwitchOn = false
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
