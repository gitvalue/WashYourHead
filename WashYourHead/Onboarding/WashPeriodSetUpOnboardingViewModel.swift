//
//  WashPeriodSetUpOnboardingViewModel.swift
//  WashYourHead
//
//  Created by Dmitry Volosach on 09/03/2024.
//

import Foundation

final class WashPeriodSetUpOnboardingViewModel: ObservableObject {
    
    // MARK: - Properties
    
    let header: String = "Давайте определим как часто вы хотите мыть голову"
    let bodyTitle: String = "Период мытья головы:"
    
    var sliderLowerBound: String { String(format: "%.0f", sliderRange.lowerBound) }
    var sliderUpperBound: String { String(format: "%.0f", sliderRange.upperBound) }
    
    let sliderRange: ClosedRange<Float> = 1...7
    let sliderStep: Float = 1
    
    @Published var sliderValue: Float = 1.0 {
        didSet {
            sliderTitle = sliderTitle(forPeriod: Int(sliderValue))
        }
    }
    
    @Published private(set) var sliderTitle: String = ""
    
    let continueButtonTitle: String = "Продолжить"
    
    // MARK: - Initialisers
    
    init() {
        sliderTitle = sliderTitle(forPeriod: Int(sliderValue))
    }
    
    // MARK: - Public
    
    func onContinueButtonPress() {
        // TODO:
    }
    
    // MARK: - Private
    
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
