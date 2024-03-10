//
//  WashPeriodSetUpOnboardingViewModel.swift
//  WashYourHead
//
//  Created by Dmitry Volosach on 09/03/2024.
//

import SwiftData
import SwiftUI

@MainActor
final class WashPeriodSetUpOnboardingViewModel: ObservableObject {
    
    // MARK: - Properties
    
    let header: String = "Давайте определим как часто вы хотите мыть голову"
    let bodyTitle: String = "Период мытья головы:"
    
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
    
    let continueButtonTitle: String = "Продолжить"
    var continueNavigationLinkDestination: some View {
        DashboardViewFactory().create(withLazyModelContext: lazyModelContext)
    }
    
    private let lazyModelContext: @MainActor () -> (ModelContext?)
     
    // MARK: - Initialisers
    
    init(lazyModelContext: @MainActor @escaping () -> (ModelContext?)) {
        self.lazyModelContext = lazyModelContext
        
        defer {
            sliderValue = 7
        }
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
